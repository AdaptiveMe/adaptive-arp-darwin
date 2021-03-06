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

    * @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

import Foundation
import AdaptiveArpApi
#if os(iOS)
import MessageUI

/**
   Interface for Managing the Messaging operations
   Auto-generated implementation of IMessaging specification.
*/
public class MessagingDelegate : UIViewController, /*BasePIMDelegate,*/ IMessaging, MFMessageComposeViewControllerDelegate { // TODO: Should delegate avoid extending UIViewController to prevent dupl. NSObject inheritance?
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "MessagingDelegate"
    
    /// Callbacks
    var smsCallback:IMessagingCallback!
    
    /**
       Group of API.
    */
    private var apiGroup : IAdaptiveRPGroup?
    
    /**
       Return the API group for the given interface.
    */
    public final func getAPIGroup() -> IAdaptiveRPGroup? {
        return self.apiGroup!
    }
    
    /**
    Return the API version for the given interface.
    */
    public final func getAPIVersion() -> String? {
        return "v2.0.3"
    }
    
    /**
       Default Constructor.
    */
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
        self.apiGroup = IAdaptiveRPGroup.PIM
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    /**
       Send text SMS

       @param number   to send
       @param text     to send
       @param callback with the result
       @since ARP1.0
    */
    public func sendSMS(number : String, text : String, callback : IMessagingCallback) {
        
        // Check if the device can send SMS
        if !(MFMessageComposeViewController.canSendText()) {
            
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The device cannot send SMS. Check the device")
            
            callback.onError(IMessagingCallbackError.NotSupported)
            return
        }
        
        // Open the view to compose the mail with the fields setted
        if let view = BaseViewController.ViewCurrent.getView() {
            
            self.smsCallback = callback
            
            // Add the MessageImplementation view controller and the subview
            view.addChildViewController(self)
            view.view.addSubview(self.view)
            
            let sms: MFMessageComposeViewController = MFMessageComposeViewController()
            sms.messageComposeDelegate = self
            sms.body = text
            sms.recipients = [number]
            
            self.presentViewController(sms, animated: true, completion: {
                self.logger.log(ILoggingLogLevel.Debug, category: self.loggerTag, message: "MFMessageComposeViewController presented")
            })
            
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is no a current view controller on the stack")
            callback.onError(IMessagingCallbackError.NotSent)
        }
    }
    
    /**
       This method is the metod called by the OS when the user leaves the sms screen. This method receives the result of the opertaion
    
       @param controller MFMessageComposeViewController used to fire this event
       @param result  Send SMS result
    */
    public func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        switch result.rawValue {
            
        case MessageComposeResultSent.rawValue :
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Message sent")
            smsCallback.onResult(true)
        case MessageComposeResultCancelled.rawValue :
            logger.log(ILoggingLogLevel.Debug, category: loggerTag, message: "Message cancelled by the user")
            smsCallback.onResult(false)
        case MessageComposeResultFailed.rawValue :
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "Message not send due to an error")
            smsCallback.onError(IMessagingCallbackError.NotSent)
        default:
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "The message delegeate received an unsuported result")
        }
        
        // Remove the view
        if (BaseViewController.ViewCurrent.getView() != nil) {
            
            // Remove the Message, Remove the view and remove the parent view controller
            self.dismissViewControllerAnimated(true, completion: nil)
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        } else {
            logger.log(ILoggingLogLevel.Error, category: loggerTag, message: "There is no a current view controller on the stack")
            smsCallback.onError(IMessagingCallbackError.Unknown)
        }
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Set the background color to transparent
        self.view.backgroundColor = UIColor.clearColor()
    }

}
    
#endif
#if os(OSX)
    
/**
   Interface for Managing the Messaging operations
   Auto-generated implementation of IMessaging specification.
*/
public class MessagingDelegate : BasePIMDelegate, IMessaging {
    
    /**
       Default Constructor.
    */
    public override init() {
        super.init()
    }
    
    /**
       Send text SMS
    
       @param number   to send
       @param text     to send
       @param callback with the result
       @since ARP1.0
    */
    public func sendSMS(number : String, text : String, callback : IMessagingCallback) {
        
        // TODO: implement this for OSX
    }
}
#endif
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
