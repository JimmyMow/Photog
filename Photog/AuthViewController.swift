//
//  AuthViewController.swift
//  Photog
//
//  Created by Jack Mallers on 10/26/14.
//  Copyright (c) 2014 Jack Mallers. All rights reserved.
//

import UIKit

enum AuthMode {
    case SignIn
    case SignUp
}

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    var authMode: AuthMode = AuthMode.SignUp
    
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        var emailImageView = UIImageView(frame: CGRectMake(0,0,50, self.emailTextField!.frame.size.height))
        emailImageView.image = UIImage(named: "EmailIcon")
        emailImageView.contentMode = .Center
        
        self.emailTextField!.leftView = emailImageView
        self.emailTextField!.leftViewMode = .Always
        
        var passwordImageView = UIImageView(frame: CGRectMake(0,0,50, self.passwordTextField!.frame.size.height))
        passwordImageView.image = UIImage(named: "PasswordIcon")
        passwordImageView.contentMode = .Center
        
        self.passwordTextField!.leftView = passwordImageView
        self.passwordTextField!.leftViewMode = .Always
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.emailTextField?.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == self.emailTextField) {
            self.emailTextField?.resignFirstResponder()
            self.passwordTextField?.becomeFirstResponder()
        } else if (textField == self.passwordTextField) {
            self.passwordTextField?.resignFirstResponder()
            
            self.authenticate()
        }
        
        return true
    }
    
    func authenticate() {
        var email = self.emailTextField?.text
        var password = self.passwordTextField?.text
        
        if (email?.isEmpty == true || password?.isEmpty == true || email?.isEmailAddress() == false) {
            self.showAlert("Uh oh!", message: "There was something wrong with your email or password", action: "OK")
            
            return
        }
        
        if(authMode == .SignIn) {
            self.signIn(email!, password: password!)
        } else {
            self.signUp(email!, password: password!)
        }
        
    }
    
    func signIn(email: String, password: String){
        PFUser.logInWithUsernameInBackground(email, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            
            if(user != nil) {
                var tabBarController = TabBarController()
                self.navigationController?.pushViewController(tabBarController, animated: true)
            } else {
                println("user sign in failed")
            }
        }
    }
    
    func signUp(email: String, password: String){
        var user = PFUser()
        user.email = email
        user.username = email
        user.password = password
        
        user.signUpInBackgroundWithBlock {
            
            (success: Bool!, error: NSError!) -> Void in
            
            if(error == nil) {
                NetworkManager.sharedInstance.follow(user, completionHandler: { (error) -> () in
                    
                    if error == nil
                    {
                        var tabBarController = TabBarController()
                        self.navigationController?.pushViewController(tabBarController, animated: true)
                    }
                    else
                    {
                        println("Unable for user to follow him/herself")
                    } 
                })
                var tabBarController = TabBarController()
                self.navigationController?.pushViewController(tabBarController, animated: true)
            } else {
                println("sign up failed")
            }
        }
        
    }
    
    
}
