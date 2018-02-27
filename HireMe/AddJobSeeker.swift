//
//  AddJobSeeker.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import Parse
import Bolts

class AddJobSeeker {
    
    var myUser = PFObject(className: "Student")
    
    
    var username : String{
        get {
            // This computed property is based on wingLength.
            return ""
        }
        set {
            // Store the results of a computation.
            myUser.setValue(newValue, forKey: "userEmail")
        }
    }
    
    var password : String{
        get {
            // This computed property is based on wingLength.
            return ""
        }
        set {
            // Store the results of a computation.
           myUser.setValue(password, forKey: "password")
        }
    }

    
    var firstname : String{
        get {
            // This computed property is based on wingLength.
            return ""
        }
        set {
            // Store the results of a computation.
            myUser.setValue(firstname, forKey: "FirstName")
        }
    }


    var lastname : String{
        get {
            // This computed property is based on wingLength.
            return ""
        }
        set {
            // Store the results of a computation.
            myUser.setValue(lastname, forKey: "LastName")
        }
    }

    var progileImage : PFFile{
        get {
            // This computed property is based on wingLength.
            return PFFile()
        }
        set {
            // Store the results of a computation.
                myUser.setValue(newValue, forKey: "ProfilePicture")
   
        }
    }

    
    func saveRecord() ->Bool{
         var userMessage = true
            myUser.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
               
                    if(!success){
                    userMessage = false
                    }
        }
        return userMessage;
    }
    
    
    

}