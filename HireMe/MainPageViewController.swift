//
//  MainPageViewController.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import UIKit
import Parse

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        

    @IBAction func signOutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userEmail")
        NSUserDefaults.standardUserDefaults().synchronize()
        
       
        
        PFUser.logOutInBackground()
        
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
        
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            var signInPage:ViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            var signInPageNav = UINavigationController(rootViewController: signInPage)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = signInPageNav
        }
        
        
        
    }

}
