/**
--| ADAPTIVE RUNTIME PLATFORM |----------------------------------------------------------------------------------------

(C) Copyright 2013-2015 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the
License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 . Unless required by appli-
-cable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the  License  for the specific language governing
permissions and limitations under the License.

Original author:

    * Carlos Lozano Diez
            <http://github.com/carloslozano>
            <http://twitter.com/adaptivecoder>
            <mailto:carlos@adaptive.me>

Contributors:

    * Ferran Vila Conesa
             <http://github.com/fnva>
             <http://twitter.com/ferran_vila>
             <mailto:ferran.vila.conesa@gmail.com>

    * See source code files for contributors.

Release:

    * @version v2.1.9

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation

/**
   Interface for Managing the OCR operations
   Auto-generated implementation of IOCR specification.
*/
public class OCRBridge : BaseReaderBridge, IOCR, APIBridge {

    /**
       API Delegate.
    */
    private var delegate : IOCR? = nil

    /**
       Constructor with delegate.

       @param delegate The delegate implementing platform specific functions.
    */
    public init(delegate : IOCR?) {
        super.init()
        self.delegate = delegate
    }
    /**
       Get the delegate implementation.
       @return IOCR delegate that manages platform specific functions..
    */
    public final func getDelegate() -> IOCR? {
        return self.delegate
    }
    /**
       Set the delegate implementation.

       @param delegate The delegate implementing platform specific functions.
    */
    public final func setDelegate(delegate : IOCR) {
        self.delegate = delegate;
    }

    /**
       Invokes the given method specified in the API request object.

       @param request APIRequest object containing method name and parameters.
       @return APIResponse with status code, message and JSON response or a JSON null string for void functions. Status code 200 is OK, all others are HTTP standard error conditions.
    */
    public override func invoke(request : APIRequest) -> APIResponse? {
        var response : APIResponse = APIResponse()
        var responseCode : Int32 = 200
        var responseMessage : String = "OK"
        var responseJSON : String? = "null"
        switch request.getMethodName()! {
            default:
                // 404 - response null.
                responseCode = 404
                responseMessage = "OCRBridge does not provide the function '\(request.getMethodName()!)' Please check your client-side API version; should be API version >= v2.1.9."
        }
        response.setResponse(responseJSON!)
        response.setStatusCode(responseCode)
        response.setStatusMessage(responseMessage)
        return response
    }
}
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
