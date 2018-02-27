//
//  JobSeeker.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import Foundation

class JobSeeker{
    
    var userEmail : String
    var password : String
    var firstName : String
    var lastName : String
    var profileImage : PFFile
    var dept : String
    var contact : String
    var skills : String
    var hours : String
    var address : String
    
    let user = PFObject(className: "Student")
    let query = PFQuery(className: "Student")
    
    init(){
        self.userEmail = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""
        self.dept = ""
        self.contact = ""
        self.address = ""
        self.skills = ""
        self.hours = ""
        self.profileImage = PFFile()

    }
    
    init(userEmail : String, password : String, firstName : String, lastName : String, dept : String, contact : String, skills : String, hours : String, address : String,profileImage : PFFile?){
        
        self.userEmail = userEmail
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.dept = dept
        self.address = address
        self.skills = skills
        self.hours = hours
        self.contact = contact
        self.profileImage = profileImage!
    }
    
    func saveRecord() ->Bool{
        
        user.setValue(userEmail, forKey: "userEmail")
        user.setValue(password, forKey: "password")
        user.setValue(firstName, forKey: "FirstName")
        user.setValue(lastName, forKey: "LastName")
        user.setValue(dept, forKey: "department")
        user.setValue(contact, forKey: "contact")
        user.setValue(skills, forKey: "skills")
        user.setValue(hours, forKey: "hoursAvailable")
        user.setValue(address, forKey: "address")
        user.setValue(profileImage, forKey: "ProfilePicture")
        
        var userMessage = true
        user.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            
            if(!success){
                userMessage = false
            }
        }
        return userMessage;
    }
    

    
    func getUserByID(emailID : String)->[AnyObject]!{
        query.whereKey("userEmail", equalTo: emailID)
       
        return query.findObjects()!
    }
    func getUserByEmailID(emailID : String)->[String]!{
        query.whereKey("userEmail", equalTo: emailID)
        var record : [String] = []
         return record
    }
    func getUserByEmail(studentUserID : String)->[AnyObject]!{
        
        query.whereKey("userEmail", equalTo: studentUserID)
        
        return query.findObjects()!
        
        
        
    }
    func getAllUsers()->[AnyObject]!{
        
        return query.findObjects()
    }
    
    func getProfilePhoto(){
        
    }
    func getUserByName(name : String)->[AnyObject]!{
        
        query.whereKey("FirsName", equalTo:  name)
        
        if(query.findObjects()?.count != 0)
        {
            return query.findObjects()!
        }
        query.whereKey("LastName", equalTo:  name)
        
        if(query.findObjects()?.count != 0)
        {
            return query.findObjects()!
        }
        return query.findObjects()!
        
    }

    
}