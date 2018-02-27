//
//  StudentApplicationTableViewController.swift
//  HireMe
//
//  Created by Manchikatla,Goutham on 12/7/15.
//  Copyright (c) 2015 Thammanaboina,Srinivas. All rights reserved.
//

import UIKit

class StudentApplicationTableViewController: UITableViewController {
    
    
   //@IBOutlet weak var menuBar: UIBarButtonItem!

    @IBOutlet weak var menuBar: UIBarButtonItem!
    
    @IBOutlet weak var tableview: UITableView!
    var keys : [String] = []
    var values : [String] = []
    override func viewDidLoad() {
        
        getData()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.keys.count
    }
    
    func getData()
    {
        
        var jobs : JobApplications = JobApplications()
        
        let userArray: [AnyObject]! = jobs.getAllJobApplications()
        
        var userMessage = "Welcome !"
        
        if(userArray == nil){
            
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else{
            
            for object in userArray {
                var title = object["jobTitle"] as! String
                var desc = object["status"] as! String
                keys.append(title)
                values.append(desc)
            }
            
        }
        
    }

    @IBAction func signUpButtonTapped(sender: AnyObject) {
        Logout().removeUserSesssion()
        
    }
   
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("jobStatus", forIndexPath: indexPath) as! UITableViewCell
        
        var jobtitle:UILabel = cell.viewWithTag(1) as! UILabel
        jobtitle.text = self.keys[indexPath.row]

        var jobstatus:UILabel = cell.viewWithTag(2) as! UILabel
        jobtitle.text = self.keys[indexPath.row]
        
       
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
