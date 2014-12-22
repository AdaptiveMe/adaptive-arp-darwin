//
//  ApplicationResource.swift
//  AppPack
//
//  Created by Carlos Lozano Diez on 05/11/14.
//  Copyright (c) 2014 Carlos Lozano Diez. All rights reserved.
//

import Foundation
import Realm

public class ResourceData : RLMObject {

    public dynamic var id : NSString = ""
    public dynamic var data : NSData = NSData()
    public dynamic var raw_type : NSString = ""
    public dynamic var raw_length : Int = 0
    dynamic var cooked : Bool = false
    dynamic var cooked_type :NSString = ""
    dynamic var cooked_length : Int = 0
    
}