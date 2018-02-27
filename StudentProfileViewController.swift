//
//  StudentProfileViewController.swift
//  HireMe
//
//  Created by A Team on 11/15/15.
//  Copyright (c) 2015 A Team. All rights reserved.
//

import UIKit

class StudentProfileViewController: UIViewController {
    
    

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var emailID: UILabel!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    @IBOutlet weak var lname: UILabel!
    
    @IBOutlet weak var fname: UILabel!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var dept: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var hoursAvailable: UILabel!
    @IBOutlet weak var skills: UILabel!
    var profilePic : PFFile = PFFile()
    var firstname  : String = ""
    var lastname  : String = ""
    var sdepartment  : String = ""
    var emailid  : String = ""
    var userSkills  : String = ""
    var userhoursAvailable  : String = ""
    var userContact  : String = ""
     var userAddress  : String = ""
    var ImageArray : UIImage = UIImage()
    
    
    @IBAction func signOutButtonTapped(sender: AnyObject) {
        Logout().removeUserSesssion()
    }
    
    var jobseeker : JobSeeker = JobSeeker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //load data from parse
        getData()
        
        
        if self.revealViewController() != nil
        {
            
            menuButton.target = self.revealViewController()
            
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    func getData()
    {
        
        var user : JobSeeker = JobSeeker()
        
        let userName:String =  NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!
        
        let userArray: [AnyObject]! = user.getUserByEmail(userName)
        println(userArray)
        
        var userMessage = "No Job Applications Found"
        
        if(userArray == nil){
            
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        else{
            
            for object in userArray {
                emailid = userName
                firstname = object["FirstName"] as! String
                lastname = object["LastName"] as! String
                sdepartment = object["department"] as! String
                userContact = object["contact"] as! String

                userSkills = object["skills"] as! String
                userhoursAvailable = object["hoursAvailable"] as! String
                userAddress = object["address"] as! String
               
                
                if let userImageFile : PFFile = object["ProfilePicture"]! as? PFFile {
                    userImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            if let imageData = imageData {
                                let image = UIImage(data:imageData)
                                self.profilePhoto.image = image
                             }
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        profileName.text = firstname+" "+lastname
        fname.text = firstname
        lname.text = lastname
        emailID.text = emailid
         dept.text = sdepartment
        address.text = userAddress
        contact.text = userContact
        skills.text = userSkills
        hoursAvailable.text = userhoursAvailable

        profilePhoto.image = ImageArray
        println(profileName)
        
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
