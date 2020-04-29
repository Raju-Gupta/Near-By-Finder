//
//  GlobalDataAccess.swift
//  NearByFinder
//
//  Created by Raju Gupta on 12/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit

class GlobalDataAccess{
    static let share = GlobalDataAccess()
    
    var currentLocation = [CurrentLocation]()
    var attribute = [Attributes]()
    var singleItem = [SingleItemInfo]()
}
