//
//  StudentHomeViewController.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import UIKit
import Parse
import Bolts
class StudentHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UISearchResultsUpdating {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
//    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var tableview: UITableView!
    var keys : [String] = []
    var values : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getData()
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)

            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            self.tableview.tableHeaderView = controller.searchBar
            controller.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)

            
            controller.searchBar.delegate = self
            
            return controller
        })()
        

        if self.revealViewController() != nil
        {
        
            menuButton.target = self.revealViewController()
            
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
            self.revealViewController().rearViewRevealWidth = 500
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOutButtonTapped(sender: AnyObject) {
        
        Logout().removeUserSesssion()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.keys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableview.dequeueReusableCellWithIdentifier("jobCell") as! UITableViewCell
        
        cell.textLabel?.text = self.keys[indexPath.row]
        
        cell.detailTextLabel?.text = self.values[indexPath.row]
        
        return cell
        
        
    }
    
    func getData()
    {
        
        var jobs : Jobs = Jobs()
        
        let userArray: [AnyObject]! = jobs.getAllJobs()
        
        var userMessage = "No Jobs Found"
        
        if(userArray == nil){
            
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else{
            
            for object in userArray {
                var title = object["jobTitle"] as! String
                var desc = object["department"] as! String
                keys.append(title)
                values.append(desc)
            }
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.jobtitle = tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.text!
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Student", bundle: nil)
        
        var mainPage:JobDetailsViewController = storyboard.instantiateViewControllerWithIdentifier("JobDetailsViewController") as! JobDetailsViewController
        
        var mainPageNav = UINavigationController(rootViewController: mainPage)
        
        appDelegate.window?.rootViewController = mainPageNav
    }
    
    //ADDED BY GOUTHAM FOR SEARCH IMPLEMENTATION
    
    var jobTitleQuery = PFQuery(className:"Jobs")
    var departmentQuery = PFQuery(className:"Jobs")
    
  
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.keys.removeAll(keepCapacity: false)
        self.values.removeAll(keepCapacity: false)
        jobTitleQuery.whereKey("jobTitle", matchesRegex: "(?i)\(searchController.searchBar.text)")
        
        departmentQuery.whereKey("department", matchesRegex: "(?i)\(searchController.searchBar.text)")
        
        var query = PFQuery.orQueryWithSubqueries([jobTitleQuery,departmentQuery])
        
        let usersearchArray: [AnyObject]! = query.findObjects()
        for object in usersearchArray {
            
            //for item in object {
            var title = object["jobTitle"] as! String
            var desc = object["department"] as! String
            keys.append(title)
            values.append(desc)
            
            
            dispatch_async(dispatch_get_main_queue()){
                
                self.tableview.reloadData()
                
            }
            
        }
        
    }
    
//    @IBAction func refreshSearchTapped(sender: AnyObject) {      
//        
//        
//        self.keys.removeAll(keepCapacity: false)
//        self.values.removeAll(keepCapacity: false)
//        getData()
//        tableview.reloadData()
//    }
    
    
    
}
