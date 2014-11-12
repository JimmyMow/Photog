//
//  UIViewController+Extensions.swift
//  Photog
//
//  Created by Jack Mallers on 10/28/14.
//  Copyright (c) 2014 Jack Mallers. All rights reserved.
//

import Foundation

extension UIViewController {
    func showAlert(title: String, message: String, action: String) {
        let alertBox = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: action, style: .Cancel, handler: nil)
        
        alertBox.addAction(alertAction)
        
        self.presentViewController(alertBox, animated: true, completion: nil)
    }
}