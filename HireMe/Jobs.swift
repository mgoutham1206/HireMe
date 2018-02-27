//
//  Jobs.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import Foundation

class Jobs{
    
    var jobTitle : String
    var jobDescription : String
    var department : String
    var appDeadline : String
    var wageRate : String
    var supervisor : String
    var hoursAvailable : String
    var address : String
    var email : String
    
    let job = PFObject(className: "Jobs")
    let query = PFQuery(className: "Jobs")
    
    init(){
        self.jobTitle = ""
        self.jobDescription = ""
        self.department = ""
        self.appDeadline = ""
        self.wageRate = ""
        self.supervisor = ""
        self.hoursAvailable = ""
        self.address = ""
        self.email = ""
    }
    init(jobTitle:String,jobDescription:String,department:String,appDeadline:String,wageRate:String,supervisor:String,hoursAvailable:String,address:String,email:String){
        self.jobTitle = jobTitle
        self.jobDescription = jobDescription
        self.department = department
        self.appDeadline = appDeadline
        self.wageRate = wageRate
        self.supervisor = supervisor
        self.hoursAvailable = hoursAvailable
        self.address = address
        self.email = email
    }
   
    func postNewJob()->Bool{
        
        job.setValue(jobTitle, forKey: "jobTitle")
        job.setValue(jobDescription, forKey: "jobDescription")
        job.setValue(department, forKey: "department")
        job.setValue(appDeadline, forKey: "applicationDeadline")
        job.setValue(wageRate, forKey: "wageRate")
        job.setValue(supervisor, forKey: "supervisor")
        job.setValue(hoursAvailable, forKey: "hoursAvailable")
        job.setValue(address, forKey: "Address")
        job.setValue(email, forKey: "Email")
        
        var userMessage : Bool = true
        job.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            
            if(!success){
                userMessage = false
            }
        }
        return userMessage
    }
    
    func getAllJobs()->[AnyObject]!{
        
        return query.findObjects()
    }
    
    func getJobByTitle(jobTitle : String)->[AnyObject]!{
       query.whereKey("jobTitle", equalTo: jobTitle)
        return query.findObjects()
    }
    
    func getJobByDepartment(department : String)->[AnyObject]!{
        query.whereKey("jobTitle", equalTo: department)
        return query.findObjects()
    }
}