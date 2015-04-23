//
//  ApplicationResource.swift
//  AppPack
//
//  Created by Carlos Lozano Diez on 05/11/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import Foundation

public class ResourceData : NSObject {
    
    var id_data : NSString = ""
    var data : NSData = NSData()
    var raw_type : NSString = ""
    var raw_length : Int64 = 0
    var cooked : Bool = false
    var cooked_type :NSString = ""
    var cooked_length : Int64 = 0
    
}