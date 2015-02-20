//
//  MainMenuViewController.swift
//  Jumper
//
//  Created by Dillon Drenzek on 2/19/15.
//  Copyright (c) 2015 OOGroup. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    
    
    
    
    @IBAction func startButtonPressed(sender: UIButton) {
        
    }
    
    @IBAction func signUpButtonPressed(sender: UIButton) {
        
    }
    
    
    @IBAction func signInButtonPressed(sender: UIButton) {
        
        
    }
    
    @IBAction func backToMainMenu(segue:UIStoryboardSegue) {
        NSLog("back to main menu")

    }
    
    @IBAction func submitNewAccount(segue:UIStoryboardSegue) {
        NSLog("submit new account")

    }
    
    
}