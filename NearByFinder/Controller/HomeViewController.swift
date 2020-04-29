//
//  HomeViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 26/03/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: BaseViewController {
    
    var latitude : CLLocationDegrees?
    var longitute : CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSetUp()
        getCoordinte()
    }
    
    func locationSetUp(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCoordinte(){
        latitude = locationManager.location?.coordinate.latitude
        longitute = locationManager.location?.coordinate.longitude
    }
    
    @IBAction func onClickCurrentLocation(_ sender: Any) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            setCurrentLocation(latitute: latitude!, longitute: longitute!)
            
            let vc = storyboard?.instantiateViewController(identifier: "SelectionViewController") as! SelectionViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else{
            defaultAlert(title: "Location Services Disabled", message: "Please enable Location Services in Settings")
        }
        
    }
    
    @IBAction func onClickCustomLocation(_ sender: Any) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            setCurrentLocation(latitute: latitude!, longitute: longitute!)
            
            let vc = storyboard?.instantiateViewController(identifier: "AddLocationViewController") as! AddLocationViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else{
            defaultAlert(title: "Location Services Disabled", message: "Please enable Location Services in Settings")
        }
        
    }
}

extension HomeViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            latitude = location.coordinate.latitude
            longitute = location.coordinate.longitude
            
            setCurrentLocation(latitute: latitude!, longitute: longitute!)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        AuthorizationSetUp(status: status)
    }
}
