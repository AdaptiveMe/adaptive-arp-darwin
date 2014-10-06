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
import MessageUI
import UIKit
import WebKit

/**
This class implements also the MFMessageComposeViewControllerDelegate in order to handle the callbacks from a sms call and the MFMailComposeViewControllerDelegate to handle mail callbacks
:see: https://github.com/hectorlr/Reddit-Scan-Swift/blob/master/Reddit%20Scan%20Swift/Views/ShareCard.swift
*/
public class MessagingImpl : NSObject, IMessaging, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    var application:UIApplication
    var wkWebView:WKWebView
    
    /// Callback for returning the sms responses
    var smsCallback: IMessagingCallback?
    
    /// Callback for returning the mail responses
    var mailCallback: IMessagingCallback?
    
    /**
    Class constructor
    */
    override init() {
        
        application = AppContextImpl().getContext() as UIApplication
        wkWebView = AppContextWebviewImpl().getWebviewPrimary() as WKWebView
    }
    
    /**
    Send an Email
    
    :param: data     the email data
    :param: callback with the result
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func sendEmail(data : Email, callback : IMessagingCallback) {
        
        // TODO: warns and errors not handled: Unable_To_Sent_All, Unable_to_fetch_attachment, Email_Account_Not_Found, SIM_Not_Present, Wrong_Params
        
        // Check if the device can send Mails
        if !MFMailComposeViewController.canSendMail() {
            
            logger.log(ILoggingLogLevel.ERROR, category: "MessagingImpl", message: "The device cannot send a mail. Check the device")
            
            callback.onError(IMessagingCallbackError.Not_Supported)
            return
        }
        
        self.mailCallback = callback
        
        // Create the email with the fields
        var mail: MFMailComposeViewController = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        
        // addresses (to)
        var recipientsTo: [String] = [String]()
        for mail:EmailAddress in data.getToRecipients(){
            recipientsTo.append(mail.getAddress())
        }
        mail.setToRecipients(recipientsTo)
        
        // addresses (cc)
        var recipientsCc: [String] = [String]()
        for mail:EmailAddress in data.getCcRecipients(){
            recipientsCc.append(mail.getAddress())
        }
        mail.setToRecipients(recipientsCc)
        
        // addresses (bcc)
        var recipientsBcc: [String] = [String]()
        for mail:EmailAddress in data.getBccRecipients(){
            recipientsBcc.append(mail.getAddress())
        }
        mail.setToRecipients(recipientsBcc)
        
        // TODO: is not using the messageBodyMimeType
        
        mail.setSubject(data.getSubject())
        mail.setMessageBody(data.getMessageBody(), isHTML: true)
        
        // atachments
        
        for attachment: AttachmentData in data.getAttachmentData() {
            
            var nsData:NSData = NSData(bytes: attachment.getData() as [Byte], length: Int(attachment.getDataSize()))
            
            mail.addAttachmentData(nsData, mimeType: attachment.getMimeType(), fileName: attachment.getFileName())
            
        }
        
        // Open the view to compose the mail with the fields setted
        wkWebView.window?.rootViewController?.presentViewController(mail, animated: true, completion: nil)
        
    }
    
    /**
    Send text SMS
    
    :param: number   to send
    :param: text     to send
    :param: callback with the result
    :author: Ferran Vila Conesa
    :since: ARP1.0
    */
    public func sendSMS(number : String, text : String, callback : IMessagingCallback) {
        
        // TODO: warns and errors not handled: SIM_Not_Present, Wrong_Params
        
        // Check if the device can send SMS
        if !MFMessageComposeViewController.canSendText() {
            
            logger.log(ILoggingLogLevel.ERROR, category: "MessagingImpl", message: "The device cannot send SMS. Check the device")
            
            callback.onError(IMessagingCallbackError.Not_Supported)
            return
        }
        
        self.smsCallback = callback

        // Create the message and set the fields
        var messageController: MFMessageComposeViewController = MFMessageComposeViewController(nibName: nil, bundle: nil)
        messageController.messageComposeDelegate = self
        messageController.body = text
        messageController.recipients = [number]
        
        // Open the view to compose the message with the fields setted
        wkWebView.window?.rootViewController?.presentViewController(messageController, animated: true, completion: nil)
    }
    
    /**
    This method is the metod called by the OS when the user leaves the smss screen. This method receives the result of the opertaion
    
    :param: sendMsg MFMessageComposeViewController used to fire this event
    :param: result  Send SMS result
    */
    public func messageComposeViewController(sendMsg: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        switch result.value {
            
        case MessageComposeResultSent.value :
            logger.log(ILoggingLogLevel.DEBUG, category: "MessagingImpl", message: "Message sent")
            smsCallback!.onResult(true)
            
        case MessageComposeResultCancelled.value :
            logger.log(ILoggingLogLevel.DEBUG, category: "MessagingImpl", message: "Message cancelled by the user")
            smsCallback!.onResult(false)
            
        case MessageComposeResultFailed.value :
            logger.log(ILoggingLogLevel.ERROR, category: "MessagingImpl", message: "Message not send due to an error")
            smsCallback!.onError(IMessagingCallbackError.Not_Sent)
            
        default:
            logger.log(ILoggingLogLevel.ERROR, category: "MessagingImpl", message: "The message delegeate received an unsuported result")
            
        }
        
        //parent.dismissViewControllerAnimated(true, completion:nil)
        
    }
    
    public func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!){
        
        switch result.value {
            
        case MFMailComposeResultCancelled.value:
            logger.log(ILoggingLogLevel.DEBUG, category: "MessagingImpl", message: "Mail cancelled by the user")
            mailCallback!.onResult(false)
            
        case MFMailComposeResultSaved.value:
            logger.log(ILoggingLogLevel.DEBUG, category: "MessagingImpl", message: "Mail saved")
            mailCallback!.onResult(true)
            
        case MFMailComposeResultSent.value:
            logger.log(ILoggingLogLevel.DEBUG, category: "MessagingImpl", message: "Mail sent")
            mailCallback!.onResult(true)
            
        case MFMailComposeResultFailed.value:
            logger.log(ILoggingLogLevel.ERROR, category: "MessagingImpl", message: "Mail not send due to an error: \(error.localizedDescription)")
            mailCallback!.onError(IMessagingCallbackError.Not_Sent)
            
        default:
            logger.log(ILoggingLogLevel.ERROR, category: "MessagingImpl", message: "The mail delegeate received an unsuported result")
        }
        
        // Close the Mail Interface
        // self.parent.dismissViewControllerAnimated(true, completion:nil)
    }
    
}