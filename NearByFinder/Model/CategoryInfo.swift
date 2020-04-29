//
//  Category.swift
//  NearByFinder
//
//  Created by Raju Gupta on 09/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit

struct CategoryInfo : Codable
{
    let categories : [Category]
    
}

struct Category : Codable
{
    let name : String
    let icon : String
    let red : CGFloat
    let green : CGFloat
    let blue : CGFloat
}


