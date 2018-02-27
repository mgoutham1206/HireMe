//
//  StudentApplicationViewController.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//
import UIKit

class StudentApplicationViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuBar: UIBarButtonItem!
//    @IBOutlet weak var menuBar: UIBarButtonItem!
//    
//    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var tableview: UITableView!
    var jobTitle : [String] = []
    var jobstatus : [String] = []
    var jobdepts : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //load from parse
        getData()
        println(jobTitle.description)
        println(jobstatus.description)
        // Do any additional setup after loading the view.
        if self.revealViewController() != nil
        {
            
            menuBar.target = self.revealViewController()
            
            menuBar.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func signoutBtnTapped(sender: AnyObject) {
        Logout().removeUserSesssion()
    }

    
    func getData()
    {
        
        var jobs : JobApplications = JobApplications()
        
        let userName:String =  NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!
        
        let userArray: [AnyObject]! = jobs.getJobApplicationStatusByStudentID(userName)
        
        
        var userMessage = "No Job Applications Found"
        
        if(userArray == nil){
            
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else{
            
            for object in userArray {
                var title = object["jobTitle"] as! String
                var status = object["status"] as! String
                var dept = object["department"] as! String
                
                jobTitle.append(title)
                jobstatus.append(status)
                jobdepts.append(dept)
            }
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("jobStatus", forIndexPath: indexPath) as! UITableViewCell
        
        var jobtitle:UILabel = cell.viewWithTag(1) as! UILabel
        jobtitle.text = self.jobTitle[indexPath.row]
        
        var dept:UILabel = cell.viewWithTag(2) as! UILabel
        dept.text = self.jobdepts[indexPath.row]
        
        var status:UILabel = cell.viewWithTag(3) as! UILabel
        status.text = self.jobstatus[indexPath.row]
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.jobTitle.count
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
