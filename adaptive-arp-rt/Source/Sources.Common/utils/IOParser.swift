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
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error reading IO config file: \(IO_CONFIG_FILE)")
        }
        
        let data: Foundation.NSData? = resourceData!.data
        if data == nil {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error reading IO config file: \(IO_CONFIG_FILE)")
        }
        
        // Create the parser and parse the xml
        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = self
        
        if !xmlParser.parse() {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Error parsing IO config file: \(IO_CONFIG_FILE)")
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
            
            currentService.setServiceEndpoints([ServiceEndpoint]())
            
        } else if elementName == IO_END_POINT {
            
            currentEndpoint = ServiceEndpoint()
            currentEndpoint.setHostURI("\(attributeDict[IO_ATTR_HOST]!)")
            currentEndpoint.setValidationType(IServiceCertificateValidation.toEnum("\(attributeDict[IO_ATTR_VALID]!)"))
            
            currentEndpoint.setPaths([ServicePath]())
            
        } else if elementName == IO_PATH {
            
            currentPath = ServicePath()
            currentPath.setPath("\(attributeDict[IO_ATTR_PATH]!)")
            currentPath.setType(IServiceType.toEnum("\(attributeDict[IO_ATTR_TYPE])"))
            
            currentPath.setMethods([IServiceMethod]())
            
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
        
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The serviceToken: \(token) is not registered in the io-config platform file")
        
        return false
    }
    
    /**
    This method returns one Service with all the configured parameter from a Service Token.
    Take care to iterate only in the first element of the inner arrays of the Bean (endpoints, paths, methods)
    
    :param: token Token with all the Service description
    
    :returns: Full service for one token
    */
    public func getServiceByToken(token:ServiceToken) -> Service? {
        
        
        // Iterate all over the services looking for one combination that
        // fits all the requirements of the Service Token
        for service:Service in services {
            if service.getName() == token.getServiceName() {
                
                var ret:Service = Service()
                ret.setName(service.getName()!)
                var retEndpoints:[ServiceEndpoint] = [ServiceEndpoint]()
                
                for endpoint:ServiceEndpoint in service.getServiceEndpoints()! {
                    if endpoint.getHostURI() == token.getEndpointName() {
                        
                        var retEndpoint:ServiceEndpoint = ServiceEndpoint()
                        retEndpoint.setHostURI(endpoint.getHostURI()!)
                        var retPaths:[ServicePath] = [ServicePath]()
                        
                        for function:ServicePath in endpoint.getPaths()! {
                            if function.getPath() == token.getFunctionName() {
                                
                                var retPath:ServicePath = ServicePath()
                                retPath.setPath(function.getPath()!)
                                retPath.setType(function.getType()!)
                                var retMethods:[IServiceMethod] = [IServiceMethod]()
                                
                                for method:IServiceMethod in function.getMethods()! {
                                    if method == token.getInvocationMethod() {
                                        
                                        var retMethod:IServiceMethod = method
                                        retMethods.append(retMethod)
                                    }
                                }
                                retPath.setMethods(retMethods)
                                retPaths.append(retPath)
                            }
                        }
                        retEndpoint.setPaths(retPaths)
                        retEndpoints.append(retEndpoint)
                    }
                }
                ret.setServiceEndpoints(retEndpoints)
                return ret
            }
        }
        
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The serviceToken: \(token) is not registered in the io-config platform file")
        return nil
    }
    
    /**
    This method returns a service token from a uri defined in the io services config file.
    
    :param: uri URI identifing one entry in the io services config file
    
    :returns: Service token populated, or nil if the uri is not defined
    */
    public func getServiceTokenByURI(uri:String) -> ServiceToken? {
        
        var uri:NSString = NSString(string: uri)
        
        if !Utils.validateUrl(uri) {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The uri: \(uri) has not a valid format")
            return nil
        }
        
        // Parse the uri
        var uriArray:[String] = uri.componentsSeparatedByString("/") as [String]
        var host = uriArray[0]+"//"+uriArray[2]
        
        var path = ""
        for var i = 3; i < uriArray.count; i++ {
            path = path + "/" + uriArray[i]
        }
        
        // If there are url parameters, remove it
        var pathArray:[String] = path.componentsSeparatedByString("?") as [String]
        path = pathArray[0]
        
        // Iterate all over the services looking for one combination that
        // fits all the requirements of the uri
        for service:Service in services {
            
            for endpoint:ServiceEndpoint in service.getServiceEndpoints()! {
                
                if Utils.validateRegexp(host, regexp: endpoint.getHostURI()!) {
                    
                    for function:ServicePath in endpoint.getPaths()! {
                        
                        if function.getPath() == path {
                            
                            var ret:ServiceToken = ServiceToken(serviceName: service.getName()!, endpointName: endpoint.getHostURI()!, functionName: function.getPath()!, invocationMethod: function.getMethods()![0])
                            
                            return ret
                        }
                    }
                }
            }
        }
        
        logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The uri: \(uri) is not registered in the io-config platform file")
        return nil
    }
    
    /**
    Method that converts the registered services on the io config file to an arrya of service tokens. Used by the implementation
    
    :returns: Array of Service Token registered in the platform
    */
    public func getServices() -> [ServiceToken] {
        
        var tokens:[ServiceToken] = [ServiceToken]()
        
        // Iterate all over the services and create an array of tokens
        for service:Service in services {
            for endpoint:ServiceEndpoint in service.getServiceEndpoints()! {
                for function:ServicePath in endpoint.getPaths()! {
                    for method:IServiceMethod in function.getMethods()! {
                        
                        var token:ServiceToken = ServiceToken(serviceName: service.getName()!, endpointName: endpoint.getHostURI()!, functionName: function.getPath()!, invocationMethod: method)
                        
                        tokens.append(token)
                    }
                }
            }
        }
        
        if tokens.count == 0 {
            logger.log(ILoggingLogLevel.Warn, category: loggerTag, message: "There are no services registered in the io platform config file.")
        }
        
        return tokens
    }
    
    /**
    Function that returns a String for the content type to use in the requests from the service configuration in the io-services configuration file
    
    :param: token Token to find a service configuration
    
    :returns: Content Type
    */
    public func getContentType(token:ServiceToken) -> String {
        
        // Iterate all over the services to match a Service
        for service:Service in services {
            for endpoint:ServiceEndpoint in service.getServiceEndpoints()! {
                for function:ServicePath in endpoint.getPaths()! {
                    
                    switch function.getType()! {
                    case IServiceType.OctetBinary:
                        return "application/octet-stream"
                    case IServiceType.RestJson:
                        return "application/json"
                    case IServiceType.RestXml:
                        return "application/xml"
                    case IServiceType.SoapXml:
                        return "application/soap+xml"
                    case IServiceType.Unknown:
                        return "text/plain"
                    }
                }
            }
        }
        
        return "text/plain"
    }
}