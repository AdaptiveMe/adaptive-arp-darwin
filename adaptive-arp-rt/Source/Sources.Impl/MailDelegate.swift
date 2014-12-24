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
#if os(iOS)
import MessageUI
/**
   Interface for Managing the Mail operations
   Auto-generated implementation of IMail specification.
*/
public class MailDelegate : UIViewController, /*BasePIMDelegate,*/ IMail, MFMailComposeViewControllerDelegate {
    
    /// Logger variable
    let logger : ILogging = AppRegistryBridge.sharedInstance.getLoggingBridge()
    let loggerTag : String = "MailDelegate"
    
    /// Callbacks
    var mailCallback:IMessagingCallback!
    
    /**
       Group of API.
    */
    private var apiGroup : IAdaptiveRPGroup?
    
    /**
       Return the API group for the given interface.
    */
    public final func getAPIGroup() -> IAdaptiveRPGroup {
        return self.apiGroup!
    }
    
    /**
       Default Constructor.
    */
    public override init() {
        super.init()
        self.apiGroup = IAdaptiveRPGroup.PIM
    }

    /**
       Send an Email

       @param data     Payload of the email
       @param callback Result callback of the operation
       @since ARP1.0
    */
    public func sendEmail(data : Email, callback : IMessagingCallback) {
        
        // Check if the device can send Mails
        if !MFMailComposeViewController.canSendMail() {
            
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "The device cannot send a mail. Check the device")
            
            callback.onError(IMessagingCallbackError.NotSupported)
            return
        }
        
        // Open the view to compose the mail with the fields setted
        if let view = BaseViewController.ViewCurrent.getView() {
            
            self.mailCallback = callback
            
            // Add the MessageImplementation view controller and the subview
            view.addChildViewController(self)
            view.view.addSubview(self.view)
            
            // Create the email with the fields
            var mail: MFMailComposeViewController = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            
            // addresses (to)
            var recipientsTo: [String] = [String]()
            for mail:EmailAddress in data.getToRecipients()!{
                recipientsTo.append(mail.getAddress()!)
            }
            mail.setToRecipients(recipientsTo)
            
            // addresses (cc)
            var recipientsCc: [String] = [String]()
            for mail:EmailAddress in data.getCcRecipients()!{
                recipientsCc.append(mail.getAddress()!)
            }
            mail.setCcRecipients(recipientsCc)
            
            // addresses (bcc)
            var recipientsBcc: [String] = [String]()
            for mail:EmailAddress in data.getBccRecipients()!{
                recipientsBcc.append(mail.getAddress()!)
            }
            mail.setBccRecipients(recipientsBcc)
            
            mail.setSubject(data.getSubject())
            mail.setMessageBody(data.getMessageBody(), isHTML: true)
            
            // atachments
            
            for attachment: EmailAttachmentData in data.getEmailAttachmentData()! {
                
                var nsData:NSData = NSData(bytes: attachment.getData()! as [Byte], length: Int(attachment.getSize()!))
                
                mail.addAttachmentData(nsData, mimeType: attachment.getMimeType(), fileName: attachment.getFileName())
                
            }
            
            self.presentViewController(mail, animated: true, completion: {
                self.logger.log(ILoggingLogLevel.DEBUG, category: self.loggerTag, message: "MFMailComposeViewController presented")
            })
            
        } else {
            logger.log(ILoggingLogLevel.ERROR, category: loggerTag, message: "There is no a current view controller on the stack")
            callback.onError(IMessagingCallbackError.NotSent)
        }
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
   Interface for Managing the Mail operations
   Auto-generated implementation of IMail specification.
*/
public class MailDelegate : BasePIMDelegate, IMail {
    
    /**
       Default Constructor.
    */
    public override init() {
        super.init()
    }
    
    /**
       Send an Email
    
       @param data     Payload of the email
       @param callback Result callback of the operation
       @since ARP1.0
    */
    public func sendEmail(data : Email, callback : IMessagingCallback) {
        // TODO: Not implemented.
    }
    
}
    
#endif
/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
