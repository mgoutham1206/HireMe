//
//  Logout.swift
//  HireMe
//
//  Created by Thammanaboina,Srinivas on 11/15/15.
//  Copyright (c) 2015 Thammanaboina,Srinivas. All rights reserved.
//

import Foundation


class Logout1:NSObject {
    
    override init() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userEmail")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        PFUser.logOutInBackground()
    }

//    func logout()
//    {
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("userEmail")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    
//        PFUser.logOutInBackground()
//    }
   

}