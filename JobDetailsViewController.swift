//
//  JobDetailsViewController.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import UIKit

class JobDetailsViewController: UIViewController {

    @IBOutlet weak var jobtitle: UILabel!
    @IBOutlet weak var jobDepartment: UILabel!
    @IBOutlet weak var details: UITextView!
    
    @IBOutlet weak var wageRate: UILabel!
    @IBOutlet weak var appDeadline: UILabel!
    @IBOutlet weak var supervisor: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var hoursAvailable: UILabel!
    
    @IBOutlet weak var email: UILabel!
     var jTitle = ""
    var desc = ""
    var departmet = ""
    var appdeadline = ""
    var wagerate = ""
    var supervisorName = ""
    var hoursavailable = ""
    var addressvalue = ""
    var emailaddress = ""
    var values : [String] = []
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var jobApplication : JobApplications = JobApplications()
    let userName:String =  NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!
    override func viewDidLoad() {
        super.viewDidLoad()
        jTitle = appDelegate.jobtitle
        getData()
        // Do any additional setup after loading the view.
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        jobtitle.text = jTitle
        jobDepartment.text = departmet
        details.text = desc
        wageRate.text = wagerate
        appDeadline.text = appdeadline
        supervisor.text = supervisorName
        address.text = addressvalue
        email.text = emailaddress
        hoursAvailable.text = hoursavailable
    }
   
    func getData(){
        
        let job : Jobs = Jobs()
        
        let userArray: [AnyObject]! = job.getJobByTitle(jTitle)
       
        var userMessage = "Welcome !"
        
        if(userArray == nil){
            //userMessage = error!.localizedDescription
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else{
            for object in userArray {
                
                addressvalue = object["Address"] as! String
                
                emailaddress = object["Email"] as! String
                
                supervisorName = object["supervisor"] as! String
                
                hoursavailable = object["hoursAvailable"] as! String
                
                desc = object["jobDescription"] as! String
                
                departmet = object["department"] as! String
                
                appdeadline = object["applicationDeadline"] as! String
                
                wagerate = object["wageRate"] as! String

      
               }
        }
        
    }

    @IBAction func backButtonTapped(sender: AnyObject) {
        
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Student", bundle: nil)
        
       var mainPage:UIViewController = mainStoryBoard.instantiateInitialViewController() as! UIViewController
        
        self.presentViewController(mainPage, animated: true, completion: nil)

    }
    
    @IBAction func signOutBtnTapped(sender: AnyObject) {
        
        Logout().removeUserSesssion()

    }

    @IBAction func applyNowbtnTapped(sender: AnyObject) {
        
        
             var isapplied =  JobApplications().isApplied(userName, jobTitle: jTitle)
        
        if(isapplied){
            var status : String = "You have already applied for the job. Thank you!"

            var myAlert = UIAlertController(title: "Alert", message: status, preferredStyle: UIAlertControllerStyle.Alert)

                         let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
                
              
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
           
                
            }
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else{
        jobApplication = JobApplications(jobTitle: jTitle, studentUserID: userName, department: departmet, status: "Application Received", comment: "We will contact you soon")
        
        var isApplied : Bool = jobApplication.saveRecord()
        
        
        var status : String = "You have successfully applied for the job. Thank you!"
        
        if(!isApplied)
        {
            status =  "Fail to apply at this time please try again later."
        }
        
        var myAlert = UIAlertController(title: "Alert", message: status, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
            
            if(isApplied)
            {
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
        }
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
    }
}
