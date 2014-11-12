//
//  UIImage+Extensions.swift
//  Photog
//
//  Created by Jack Mallers on 11/10/14.
//  Copyright (c) 2014 Jack Mallers. All rights reserved.
//

import Foundation

extension UIImage {
    func resize(targetWidth: CGFloat) -> UIImage {
        var originalWidth = self.size.width
        
        if originalWidth <= targetWidth {
            return self
        }
        
        var scaleFactor = targetWidth / targetWidth
        var targetHeight = self.size.height * scaleFactor
        
        var newSize = CGSizeMake(targetWidth, targetHeight)
        UIGraphicsBeginImageContext(newSize)
        
        self.drawInRect(CGRectMake(0, 0, targetWidth, targetHeight))
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
}