//
//  ViewController.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import UIKit
import Parse
import Bolts
class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTextFields()
        
    }
    
    
    func initializeTextFields() {
        userEmailAddressTextField.delegate = self
        userEmailAddressTextField.keyboardType = UIKeyboardType.ASCIICapable
        
        userPasswordTextField.delegate = self
        userPasswordTextField.keyboardType = UIKeyboardType.ASCIICapable
        
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(testStr)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signInButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailAddressTextField.text
        let userPassword = userPasswordTextField.text
        
        if(userEmail.isEmpty && userPassword.isEmpty)
        {
            
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Username and Password", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
            
        }
        if(userEmail.isEmpty)
        {
            
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Valid UserName", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
            
        }
        
        if(!isValidEmail(userEmail!)) {
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Valid EmailId", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
      
        if(userPassword.isEmpty)
        {
            
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Password", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
            
        }
        
        if(userEmail == "bearcats@gmail.com" && userPassword == "bearcats")
        {
            
            NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
            NSUserDefaults.standardUserDefaults().synchronize()
            let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Admin", bundle: nil)
            
            var mainPage:PostJobViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("PostJobViewController") as! PostJobViewController
            
            var mainPageNav = UINavigationController(rootViewController: mainPage)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = mainPageNav
            
        }
        
        
        var jobSeeker:JobSeeker = JobSeeker()
        
        
        let userArray: [AnyObject]! = jobSeeker.getUserByID(userEmail)
        
        println(userArray.count)
        
        var userMessage = "No User Found, Please  Register"
        
        if(userArray.count == 0){
           
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else{
            for object in userArray {
                
                var username = object["userEmail"] as! String
                
                var pwd = object["password"] as! String
                
                if(userEmail == username && userPassword == pwd){
                    
                    NSUserDefaults.standardUserDefaults().setObject(username, forKey: "userEmail")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Student", bundle: nil)
                    
                    var mainPage:UIViewController = mainStoryBoard.instantiateInitialViewController() as! UIViewController
                    
                    self.presentViewController(mainPage, animated: true, completion: nil)
                }else{
                    userMessage = "You have Entered Wrong Password"
                    var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    
                    myAlert.addAction(okAction)
                    
                    self.presentViewController(myAlert, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
}

