//
//  ParseConfig.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import Parse
import Bolts

class ParseConfig:NSObject {
    
    
    let myParseId : String = "srinivasthammana99@gmail.com"
    let myPaesePassword : String = "maryville@123"
      override init() {
        Parse.enableLocalDatastore()
       
        // Initialize Parse.
        Parse.setApplicationId("lE20cgvFcQqMsViOgnbZh0lmmnUnTPaemHYfRBfW",
            clientKey: "uWCWqWh4eqFBRNEmKNVcHt2ayZ24J0u1mZiQ5P0Z")
    }
}
