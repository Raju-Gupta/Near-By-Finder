//
//  GlobalAccess.swift
//  NearByFinder
//
//  Created by Raju Gupta on 12/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import MapKit

struct CurrentLocation {
    var latitute : CLLocationDegrees
    var longitute : CLLocationDegrees
}

struct Attributes {
    var titleStr : String
    var icon : String
    var red : CGFloat
    var green : CGFloat
    var blue : CGFloat
}

struct SingleItemInfo {
    var name : String
    var phone : String
    var url : String
    var placemark : MKPlacemark
    var coordinate : CLLocationCoordinate2D
}
