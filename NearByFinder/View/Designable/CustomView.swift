//
//  CustomView.swift
//  NearByFinder
//
//  Created by Raju Gupta on 03/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
@IBDesignable
class CustomView: UIView {

    @IBInspectable var viewRadius : CGFloat = 0{
        didSet{
            layer.cornerRadius = viewRadius
        }
    }

}
