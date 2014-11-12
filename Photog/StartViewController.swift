//
//  StartViewController.swift
//  Photog
//
//  Created by Jack Mallers on 10/17/14.
//  Copyright (c) 2014 Jack Mallers. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        
        var viewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        viewController.authMode = .SignIn
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func didTapSignUp(sender: AnyObject) {
        var viewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        viewController.authMode = .SignUp
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
