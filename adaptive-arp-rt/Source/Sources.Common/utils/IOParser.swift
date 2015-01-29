/*
* =| ADAPTIVE RUNTIME PLATFORM |=======================================================================================
*
* (C) Copyright 2013-2014 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
* the License. You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
* an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
* specific language governing permissions and limitations under the License.
*
* Original author:
*
*     * Carlos Lozano Diez
*                 <http://github.com/carloslozano>
*                 <http://twitter.com/adaptivecoder>
*                 <mailto:carlos@adaptive.me>
*
* Contributors:
*
*     * Ferran Vila Conesa
*                 <http://github.com/fnva>
*                 <http://twitter.com/ferran_vila>
*                 <mailto:ferran.vila.conesa@gmail.com>
*
* =====================================================================================================================
*/
import Foundation

public class IOParser : NSObject, NSXMLParserDelegate {
    
    /// Singleton instance
    public class var sharedInstance : IOParser {
        struct Static {
            static let instance : IOParser = IOParser()
        }
        return Static.instance
    }
    
    /// Logging variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "IOParser"
    
    /// io config file
    let IO_CONFIG_FILE: String = "io-config.xml";
    
    let IO_IO_CONFIG: String = "io-config"
    let IO_SERVICES: String = "services"
    let IO_SERVICE: String = "service"
    let IO_END_POINT: String = "end-point"
    let IO_PATH: String = "path"
    let IO_METHOD: String = "method"
    let IO_RESOURCES: String = "resources"
    let IO_RESOURCE: String = "resource"
    
    let IO_ATTR_NAME: String = "name"
    let IO_ATTR_HOST: String = "host"
    let IO_ATTR_VALID: String = "validation"
    let IO_ATTR_PATH: String = "path"
    let IO_ATTR_TYPE: String = "type"
    let IO_ATTR_METHOD: String = "method"
    let IO_ATTR_URL: String = "url"
    
    /// Resources supported by the application
    var resources:[String]!
    
    /// Registered Services by the application
    var services:[Service]!
    var currentService:Service!
    var currentEndpoint:ServiceEndpoint!
    var currentPath:ServicePath!
    
    /**
    Class constructor
    */
    public override init(){
        super.init()
        resources = [String]()
        services = [Service]()
        
        // Read the io config file
        var resourceData : ResourceData? = AppResourceManager.sharedInstance.retrieveConfigResource(IO_CONFIG_FILE)
        if resourceData == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading IO config file: \(IO_CONFIG_FILE)")
        }
        
        let data: Foundation.NSData? = resourceData!.data
        if data == nil {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error reading IO config file: \(IO_CONFIG_FILE)")
        }
        
        // Create the parser and parse the xml
        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = self
        
        if !xmlParser.parse() {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "Error parsing IO config file: \(IO_CONFIG_FILE)")
        }
    }
    
    /**
    Method involved in the xml parse response
    
    :param: parser        XML parser
    :param: elementName   name of the element
    :param: namespaceURI  namespace uri of the element
    :param: qName         qName of the element
    :param: attributeDict dictionary of attributes
    */
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        
        if elementName == IO_RESOURCE {
            resources.append("\(attributeDict[IO_ATTR_URL]!)")
            
        } else if elementName == IO_SERVICE {
            
            currentService = Service()
            currentService.setName("\(attributeDict[IO_ATTR_NAME]!)")
            
        } else if elementName == IO_END_POINT {
            
            currentEndpoint = ServiceEndpoint()
            currentEndpoint.setHostURI("\(attributeDict[IO_ATTR_HOST]!)")
            currentEndpoint.setValidationType(IServiceCertificateValidation.toEnum("\(attributeDict[IO_ATTR_VALID]!)"))
            
        } else if elementName == IO_PATH {
            
            currentPath = ServicePath()
            currentPath.setPath("\(attributeDict[IO_ATTR_PATH]!)")
            currentPath.setType(IServiceType.toEnum("\(attributeDict[IO_ATTR_TYPE])"))
            
        } else if elementName == IO_METHOD {
            
            var methods:[IServiceMethod] = currentPath.getMethods()!
            methods.append(IServiceMethod.toEnum("\(attributeDict[IO_ATTR_METHOD]!)"))
            currentPath.setMethods(methods)
        }
    }
    
    /**
    Method involved in the xml parse response
    
    :param: parser        XML parser
    :param: elementName   name of the element
    :param: namespaceURI  namespace uri of the element
    :param: qName         qName of the element
    */
    public func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if elementName == IO_SERVICE {
            
            services.append(currentService)
            
        } else if elementName == IO_END_POINT {
            
            var serviceEndpoints:[ServiceEndpoint] = currentService.getServiceEndpoints()!
            serviceEndpoints.append(currentEndpoint)
            currentService.setServiceEndpoints(serviceEndpoints)
            
        } else if elementName == IO_PATH {
            
            var paths:[ServicePath] = currentEndpoint.getPaths()!
            paths.append(currentPath)
            currentEndpoint.setPaths(paths)
        }
    }
    
    /**
    Function that validates a resource for the application. Every resource has to be define in the io config file
    
    :param: url URl to validate
    
    :returns: true if valid, false otherwise
    */
    public func validateResource(url:String) -> Bool {
        
        for resource:String in resources {
            if Utils.validateRegexp(url, regexp: resource) {
                return true
            }
        }
        return false
    }
    
    /**
    Funtion that validates if a service is registered on the IO configuration file
    
    :param: token Token to make a request
    
    :returns: True if is registered, false otherwise
    */
    public func validateService(token:ServiceToken) -> Bool {
        
        // Iterate all over the services looking for one combination that
        // fits all the requirements of the Service Token
        for service:Service in services {
            
            // name
            if service.getName() == token.getServiceName() {
                for endpoint:ServiceEndpoint in service.getServiceEndpoints()! {
                    
                    // host
                    if endpoint.getHostURI() == token.getEndpointName() {
                        for function:ServicePath in endpoint.getPaths()! {
                            
                            // function
                            if function.getPath() == token.getFunctionName() {
                                for method:IServiceMethod in function.getMethods()! {
                                    
                                    // method
                                    if method == token.getInvocationMethod() {
                                        return true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return false
    }
}