//
//  CustomNavigationC.swift
//  RecipeApp
//
//  Created by Raju Gupta on 29/12/19.
//  Copyright © 2019 Raju Gupta. All rights reserved.
//

import UIKit

class CustomNavigationC: UINavigationController {

    //static var shareNav = CustomNavigationC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationSetUp()
    }
    
    func navigationSetUp()
    {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
}
