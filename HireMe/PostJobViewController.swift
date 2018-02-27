//
//  PostJobViewController.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import UIKit

class PostJobViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate {
    
    var picker = UIPickerView()
    var datePicker = UIDatePicker()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    var dropdowndata = ["Applied Computer Science","Campus Dining","Career Services","Talent Devlopment Center","Welness Center","Accounting","International Affairs"]
    
    
    @IBOutlet weak var jobtitleTextbox: UITextField!
    @IBOutlet weak var jobdescriptionTextbox: UITextView!
    @IBOutlet weak var departmentTextbox: UITextField!
    
    @IBOutlet weak var applicationDeadline: UITextField!
    
    @IBOutlet weak var wageRate: UITextField!
    
    @IBOutlet weak var supervisor: UITextField!
    @IBOutlet weak var hoursAvailable: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobtitleTextbox.delegate = self
        applicationDeadline.delegate = self
        departmentTextbox.delegate = self
        jobdescriptionTextbox.delegate = self
        wageRate.delegate = self
        supervisor.delegate = self
        hoursAvailable.delegate = self
        address.delegate = self
        email.delegate = self
        
        picker.delegate = self
        picker.dataSource = self
        departmentTextbox.inputView = picker
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.addTarget(self, action: "datePickerValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        applicationDeadline.inputView = datePicker
        
        initializeTextFields()
        
        
      
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func initializeTextFields() {
        jobtitleTextbox.delegate = self
        jobtitleTextbox.keyboardType = UIKeyboardType.ASCIICapable
        
        jobdescriptionTextbox.delegate = self
        jobdescriptionTextbox.keyboardType = UIKeyboardType.ASCIICapable
        
        email.delegate = self
        email.keyboardType = UIKeyboardType.EmailAddress
        
        hoursAvailable.delegate = self
        hoursAvailable.keyboardType = UIKeyboardType.NumbersAndPunctuation
        
        wageRate.delegate = self
        wageRate.keyboardType = UIKeyboardType.DecimalPad
        
        address.delegate = self
        address.keyboardType = UIKeyboardType.ASCIICapable
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        applicationDeadline.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return dropdowndata.count
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        departmentTextbox.text = dropdowndata[row]
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return dropdowndata[row]
    }
    
    @IBAction func signOutBtnTapped(sender: AnyObject) {
        
        Logout().removeUserSesssion()
    }
    
    @IBAction func postJobButtonTapped(sender: AnyObject) {
        
        let jobTitle = jobtitleTextbox.text
        let jobDescription = jobdescriptionTextbox.text
        let dept = departmentTextbox.text
        let deadline = applicationDeadline.text
        let wage = wageRate.text
        let supervisorName = supervisor.text
        let hours = hoursAvailable.text
        let addr = address.text
        let emailID = email.text
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.stringFromDate(date)
        
        print("hi ")
        println(deadline)
        print("hello ")
        println(formatter.stringFromDate(date))
        
        
//        if(jobTitle.isEmpty || jobDescription.isEmpty || dept.isEmpty || wage.isEmpty || supervisorName.isEmpty || hours.isEmpty || addr.isEmpty || emailID.isEmpty || deadline.isEmpty){
//            var myAlert = UIAlertController(title: "Alert", message: "All fields are Required to fill in", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//            
//            myAlert.addAction(okAction)
//            
//            self.presentViewController(myAlert, animated: true, completion: nil)
//            
//            return
//        }
        
        if(jobTitle.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Job titile", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(jobDescription.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Job Description", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if(dept.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Select Depatment", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(wage.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Wage Rate", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if(supervisorName.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Supervisor Name", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if(hours.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Hours Available", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
//        if(hoursAvailable.text.{
//        var myAlert = UIAlertController(title: "Alert", message: "Please Enter Hours Available", preferredStyle: UIAlertControllerStyle.Alert)
//        
//        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//        
//        myAlert.addAction(okAction)
//        
//        self.presentViewController(myAlert, animated: true, completion: nil)
//        
//        return
//        }
        
        if(addr.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Address", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(emailID.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter emailID", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        var jobs : Jobs = Jobs(jobTitle: jobTitle, jobDescription: jobDescription, department: dept,appDeadline:deadline,wageRate:wage,supervisor:supervisorName,hoursAvailable:hours,address:addr,email:emailID)
        
        var isPosted : Bool = jobs.postNewJob()
        
        
        var status : String = "You have successfully posted job details. Thank you!"
        
        if(!isPosted)
        {
            status =  "Failed to post job details at this time please try again later."
        }
        
        var myAlert = UIAlertController(title: "Alert", message: status, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
            
            if(isPosted)
            {
                //                let adminStoryBoard:UIStoryboard = UIStoryboard(name: "Admin", bundle: nil)
                //
                //                var page:PostJobViewController = adminStoryBoard.instantiateViewControllerWithIdentifier("PostJobViewController") as! PostJobViewController
                //
                //                self.presentViewController(page, animated: true, completion: nil)
                
                let adminStoryBoard:UIStoryboard = UIStoryboard(name: "Admin", bundle: nil)
                
                var mainPage:PostJobViewController = adminStoryBoard.instantiateViewControllerWithIdentifier("PostJobViewController") as! PostJobViewController
                
                var mainPageNav = UINavigationController(rootViewController: mainPage)
                
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = mainPageNav
                
            }
            
        }
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        }
        
    
    
    
        //        var myUser = PFObject(className: "Jobs")
        //
        //        myUser.setValue(jobTitle, forKey: "jobTitle")
        //        myUser.setValue(jobDescription, forKey: "jobDescription")
        //        myUser.setValue(dept, forKey: "department")
        //
        //
        //        myUser.saveInBackgroundWithBlock {
        //            (success: Bool, error: NSError?) -> Void in
        //            var userMessage = "You have posted job successfully. Thank you!"
        //
        //            if(!success){
        //                userMessage = "Failed to post this job at this time please try again later."
        //                userMessage = error!.localizedDescription
        //            }
        //
        //            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        //
        //            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
        //
        //                if(success)
        //                {
        //                    //self.dismissViewControllerAnimated(true, completion: nil)
        //                   // self.presentViewController(PostJobViewController, animated: true, completion: nil)
        //                    //self.presentViewController(viewControllerToPresent: UIViewController, animated: <#Bool#>, completion: <#(() -> Void)?##() -> Void#>)
        //
        //                    let adminStoryBoard:UIStoryboard = UIStoryboard(name: "Admin", bundle: nil)
        //
        //                    var page:PostJobViewController = adminStoryBoard.instantiateViewControllerWithIdentifier("PostJobViewController") as! PostJobViewController
        //
        //                    self.presentViewController(page, animated: true, completion: nil)
        //                }
        //
        //            }
        //
        //            myAlert.addAction(okAction)
        //
        //            self.presentViewController(myAlert, animated: true, completion: nil)
        //
        //        }
        //
    
    
}
