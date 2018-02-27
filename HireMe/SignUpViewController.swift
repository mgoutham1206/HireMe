//
//  SignUpViewController.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
    
    var picker = UIPickerView()
    var dropdowndata = ["Campus Dining","Career Services","Talent Devlopment Center","Applied Computer Science","Welness Center","Accounting","International Affairs"]
    
    var addstudent:AddJobSeeker = AddJobSeeker()
    
    var user : JobSeeker = JobSeeker()
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    
    
    @IBOutlet weak var department: UITextField!
    
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!
    
    
    @IBOutlet weak var userFirstNameTextField: UITextField!
    
    @IBOutlet weak var userLastNameTextField: UITextField!
    
    @IBOutlet weak var skills: UITextField!
    @IBOutlet weak var hoursAvailable: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var address: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailAddressTextField.delegate = self
        userPasswordTextField.delegate = self
        userRepeatPasswordTextField.delegate = self
        userFirstNameTextField.delegate = self
        userLastNameTextField.delegate = self
        skills.delegate = self
        hoursAvailable.delegate = self
        contact.delegate = self
        address.delegate = self
        
        picker.delegate = self
        picker.dataSource = self
        department.inputView = picker
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(testStr)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        return dropdowndata.count
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        department.text = dropdowndata[row]
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return dropdowndata[row]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion:nil )
    }
    
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        
        let userName = userEmailAddressTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = userRepeatPasswordTextField.text
        let userFirstName = userFirstNameTextField.text
        let userLastName = userLastNameTextField.text
        let userdept = department.text
        let userskills = skills.text
        let userhoursavailable = hoursAvailable.text
        let usercontact = contact.text
        let useraddress = address.text
        
        if(userName.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter UserName", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(!isValidEmail(userName!)) {
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Valid EmailId", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(userPassword.isEmpty || userRepeatPassword.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Password", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        
        if(userPassword != userRepeatPassword){
            var myAlert = UIAlertController(title: "Alert", message: "Password do not match. Please try again", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if(userFirstName.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter FirstName", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(userLastName.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter LastName", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(userskills.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Skills", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(userhoursavailable.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Hours Available per Week", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(usercontact.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Contact Number", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        if(useraddress.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please Enter Address", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        let profileImageData = UIImageJPEGRepresentation(profilePhotoImageView.image, 1)
        
        if(profileImageData != nil){
            // create PFA object to be sent to Parse cloud service
            let profileImageFile = PFFile(data: profileImageData)
            user  = JobSeeker(userEmail: userName, password: userPassword, firstName: userFirstName, lastName: userLastName, dept: userdept, contact: usercontact, skills: userskills, hours: userhoursavailable, address: useraddress, profileImage: profileImageFile)
            
            
        }
            
        else{
            user  = JobSeeker(userEmail: userName, password: userPassword, firstName: userFirstName, lastName: userLastName, dept: userdept, contact: usercontact, skills: userskills, hours: userhoursavailable, address: useraddress, profileImage: nil)
        }
        var isSaved:Bool = user.saveRecord()
        
        
        
        var status : String = "Registration is successful. Thank you!"
        
        if(!isSaved)
        {
            status =  "Could not register at this time please try again later."
        }
        
        var myAlert = UIAlertController(title: "Alert", message: status, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
            
            if(isSaved)
            {
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
        }
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
