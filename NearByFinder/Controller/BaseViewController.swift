//
//  BaseViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 26/03/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import RevealingSplashView

class BaseViewController: UIViewController {

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func splashScreenSetUp(){
        let revealinSplashView = RevealingSplashView(iconImage: #imageLiteral(resourceName: "logo"), iconInitialSize: CGSize(width: 200, height: 200), backgroundColor: UIColor.red)
        self.view.addSubview(revealinSplashView)
        revealinSplashView.animationType = .squeezeAndZoomOut
        revealinSplashView.startAnimation()
    }
    
    func defaultAlert(title : String, message : String){
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                   // print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setCurrentLocation(latitute: CLLocationDegrees, longitute: CLLocationDegrees){
        GlobalDataAccess.share.currentLocation.removeAll()
        GlobalDataAccess.share.currentLocation.append(CurrentLocation(latitute: latitute, longitute: longitute))
    }
    
    
    func AuthorizationSetUp(status : CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            break
            
        case .denied:
            defaultAlert(title: "Location Services Disabled", message: "Please enable Location Services in Settings")
            break
        case .restricted:
            defaultAlert(title: "Location Services Restricted", message: "Your location service is restricted for this application.")
            break
            
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            break
            
        default:
            break
        }
    }

}
