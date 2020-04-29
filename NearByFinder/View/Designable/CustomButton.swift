//
//  CustomButton.swift
//  NearByFinder
//
//  Created by Raju Gupta on 02/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton : UIButton
{
    @IBInspectable var btnRadius : CGFloat = 0
        {
        didSet
        {
            layer.cornerRadius = btnRadius
        }
    }
    
    @IBInspectable var btnBorderWith : CGFloat = 0
        {
        didSet
        {
            layer.borderWidth = btnBorderWith
        }
    }
    
    @IBInspectable var btnBorderColor : UIColor = .clear
        {
        didSet
        {
            layer.borderColor = btnBorderColor.cgColor
        }
    }
}
