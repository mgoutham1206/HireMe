//
//  JobApplications.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import Foundation


class JobApplications{
    
    var jobTitle : String
    var studentUserID : String
    var department : String
    var status : String
    var comment : String
    
    
    let user = PFObject(className: "JobApplications")
    let query = PFQuery(className: "JobApplications")
    
    init(){
        self.jobTitle = ""
        self.studentUserID = ""
        self.department = ""
        self.status = ""
        self.comment = "Not Reviewed"
        
    }
    
    init(jobTitle : String, studentUserID : String, department : String, status : String, comment : String){
        
        self.jobTitle = jobTitle
        self.studentUserID = studentUserID
        self.department = department
        self.status = status
        self.comment = comment
    }
    
    func saveRecord() ->Bool{
        
        user.setValue(jobTitle, forKey: "jobTitle")
        user.setValue(studentUserID, forKey: "studentUserID")
        user.setValue(department, forKey: "department")
        user.setValue(status, forKey: "status")
        user.setValue(comment, forKey: "comment")
        
        var userMessage = true
        user.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            
            if(!success){
                userMessage = false
            }
        }
        return userMessage;
    }
    
    func getAllJobApplications()->[AnyObject]!{
        
        return query.findObjects()
    }
    
    
    func getJobApplicationByTitle(jobTitle : String)->[AnyObject]!{
        query.whereKey("jobTitle", equalTo: jobTitle)
        return query.findObjects()!
    }
    
    func getJobApplicationByStudentID(studentUserID : String)->[String]!{
        query.whereKey("studentUserID", equalTo: studentUserID)
        
        var record : [String] = []
        for i in query.findObjects()! {
            
            record.append((i["jobTitle"] as? String)!)
            record.append((i["studentUserID"] as? String)!)
            record.append((i["department"] as? String)!)
            record.append((i["status"] as? String)!)
            record.append((i["comment"] as? String)!)
        }
        
        return record
        
    }
    func getJobApplicationStatusByStudentID(studentUserID : String)->[AnyObject]!{
        query.whereKey("studentUserID", equalTo: studentUserID)
        return query.findObjects()!
        
    }
    
    func getJobApplicationsBydepartment(department : String)->[AnyObject]!{
        query.whereKey("department", equalTo: department)
        return query.findObjects()!
    }
    
    func isApplied(studentid : String,jobTitle : String)->Bool{
        query.whereKey("jobTitle", equalTo: jobTitle)
        var isExist = false
        for i in query.findObjects()! {
           var s = (i["studentUserID"] as? String)!
            
            if(s==studentid){
                isExist = true
            }
           
        }
        return isExist
    }
}