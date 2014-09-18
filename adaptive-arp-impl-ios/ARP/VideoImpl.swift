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
import MediaPlayer
import UIKit
import WebKit

public class VideoImpl : IVideo {
    
    /// Logging variable
    let logger : ILogging = LoggingImpl()
    
    /// Movie player
    var moviePlayer:MPMoviePlayerController!
    
    /// Primary webview
    var wkWebView:WKWebView
    
    /// Aplication
    var application:UIApplication
    
    /**
    Class constructor
    */
    init() {
        
        wkWebView = AppContextWebviewImpl().getWebviewPrimary() as WKWebView
        application = AppContextImpl().getContext() as UIApplication
    }
    
    /**
    Play url video stream
    
    :param: url url of the video
    */
    public func playStream(url : String) {
        
        // Check the url for malforming
        if(Utils.validateUrl(url)){
            self.logger.log(ILoggingLogLevel.ERROR, category: "VideoImpl", message: "Url malformed: \(url)")
            return
        }
        
        var url:NSURL = NSURL(string: url)!
        
        // Check if it is possible to open the url
        if !application.canOpenURL(url) {
            
            logger.log(ILoggingLogLevel.ERROR, category: "VideoImpl", message: "The url: \(url) is not possible to open by the application")
            return
        }
        
        moviePlayer = MPMoviePlayerController(contentURL: url)
        
        // TODO: check this magic numbers
        moviePlayer.view.frame = CGRect(x: 20, y: 100, width: 200, height: 150)
        
        wkWebView.addSubview(moviePlayer.view)
        
        //self.view.addSubview(moviePlayer.view)
        
        moviePlayer.fullscreen = true
        
        moviePlayer.controlStyle = MPMovieControlStyle.Embedded
    }
}