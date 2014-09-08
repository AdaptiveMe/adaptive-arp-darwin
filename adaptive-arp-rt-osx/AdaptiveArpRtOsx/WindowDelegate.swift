//
//  WindowDelegate.swift
//  AdaptiveArpRtOsx
//
//  Created by Carlos Lozano Diez on 05/09/2014.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import Cocoa

class WindowDelegate: NSObject, NSWindowDelegate {
    func windowWillClose(notification: NSNotification?) {
        NSApplication.sharedApplication().terminate(0)
    }
}