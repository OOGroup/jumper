//
//  MainMenuViewController.swift
//  Jumper
//
//  Created by Dillon Drenzek on 2/19/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

import UIKit
import Parse

class MainMenuViewController: UIViewController {
    
    

   
    @IBOutlet weak var viewLevelsButton: UIButton!
    @IBOutlet var currentLevelLabel: UILabel!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userUpdated()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        userUpdated()
        self.view.setNeedsUpdateConstraints()
    }
    
    func userUpdated () {
        var user = PFUser.currentUser()
        
        if (user != nil) {
            user.fetchInBackgroundWithBlock { (fetchedUser, error) -> Void in
                if (error == nil) {
                    let currentLevel:NSNumber = user["currentLevel"] as! NSNumber
                    
                    self.userLabel.text = NSString(format: "Current User: %@", user.username) as String
                    self.currentLevelLabel.text = NSString(format: "Current Level: %@", currentLevel) as String
                    self.signInButton.hidden = true
                    self.signUpButton.hidden = true
                    self.startButton.hidden = false
                    self.signOutButton.hidden = false
                    self.viewLevelsButton.hidden = false
                    
                    self.view.setNeedsUpdateConstraints()
                } else {
                    println(error)
                    return
                }
            }
        } else {
            
            self.userLabel.text = "No Current User"
            self.currentLevelLabel.text = ""
            self.signInButton.hidden = false
            self.signUpButton.hidden = false
            self.startButton.hidden = true
            self.signOutButton.hidden = true
            self.viewLevelsButton.hidden = true
            
            self.view.setNeedsUpdateConstraints()
        }
    }
    
    @IBAction func viewLevelsButtonPressed(sender:UIButton) { }
    @IBAction func startButtonPressed(sender: UIButton) { }
    @IBAction func signUpButtonPressed(sender: UIButton) {}
    @IBAction func signInButtonPressed(sender: UIButton) {}
    @IBAction func signOutButtonPressed(sender: UIButton) {
        if((PFUser.currentUser()) != nil) {
            let username = PFUser.currentUser().username
            PFUser.logOut()
            UIAlertView(title: "Logged Out", message: NSString(format: "%@ has logged out.", username) as String, delegate: nil, cancelButtonTitle: "Okay").show()
            userUpdated()
 
        } else {
            UIAlertView(title: "No Current User", message: "There is no current user to sign out.", delegate: nil, cancelButtonTitle: "Okay").show()
            userUpdated()
        }
    }
    
    @IBAction func backToMainMenu(segue:UIStoryboardSegue) {}
    @IBAction func submitNewAccount(segue:UIStoryboardSegue) {
        
        let source: SignUpViewController = segue.sourceViewController as! SignUpViewController
        let inputUsername: String = source.usernameTextField.text
        let inputPassword: String = source.passwordTextField.text
        let inputConfirm: String = source.confirmTextField.text
        
        if (inputPassword == inputConfirm) {
            var newUser = PFUser()
            newUser.username = inputUsername
            newUser.password = inputPassword
            newUser["currentLevel"] = 1
            
            newUser.signUpInBackgroundWithBlock({ (success, error) -> Void in
                if (success) {
                    
                    UIAlertView(title: "Success!", message: String(format: "Created new user: %@", inputUsername), delegate: nil, cancelButtonTitle: "Okay").show()
                    self.userUpdated()
                    
                } else {
                    UIAlertView(title: "Error", message: String(format: "Error: %@", error), delegate: nil, cancelButtonTitle: "Okay").show()
                    self.userUpdated()
                }
            })
            
        } else {
            UIAlertView(title: "Error.", message: "The two passwords you input do not match", delegate: nil, cancelButtonTitle: "Okay").show()
        }

    }
    
    @IBAction func logIn(segue:UIStoryboardSegue) {
        
        let source: SignInViewController = segue.sourceViewController as! SignInViewController
        let inputUsername: NSString = source.usernameTextField.text
        let inputPassword: NSString = source.passwordTextField.text
        
        PFUser.logInWithUsernameInBackground(inputUsername as String, password: inputPassword as String) { (user:PFUser!, error:NSError!) -> Void in
            if (error == nil) {
                UIAlertView(title: "Success!", message: String(format: "Logged in as user: %@", inputUsername), delegate: nil, cancelButtonTitle: "Okay").show()
                self.userUpdated()

            } else {
                UIAlertView(title: "Error", message: String(format: "Error: %@", error), delegate: nil, cancelButtonTitle: "Okay").show()
                self.userUpdated()
            }
        }
        
    }
    
    
}