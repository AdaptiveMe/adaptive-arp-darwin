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

import Cocoa
import AVKit

public class BaseViewController: NSViewController {
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init() {
        super.init()
    }
    
    /// Maintain a static reference to current and previous views
    public struct ViewCurrent {
        private static var instance : NSViewController?
        public static func getView() -> NSViewController? {
            return instance
        }
        static func setView(view : NSViewController) {
            instance = view
        }
        
    }
    
    public struct ViewPrevious {
        private static var instance : NSViewController?
        public static func getView() -> NSViewController? {
            return instance
        }
        static func setView(view : NSViewController) {
            instance = view
        }
        
    }
    
    /**
    Called after the view controller’s view has been loaded into memory is about to be added to the view hierarchy in the window.
    */
    override public func viewWillAppear() {
        super.viewWillAppear()
        if ViewPrevious.getView()==nil && ViewCurrent.getView()==nil {
            ViewCurrent.setView(self)
        } else if (ViewCurrent.getView() != nil) {
            ViewPrevious.setView(ViewCurrent.getView()!)
            ViewCurrent.setView(self)
        }
    }
    
}