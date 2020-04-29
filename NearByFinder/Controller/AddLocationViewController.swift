//
//  AddLocationViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 27/03/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class AddLocationViewController: BaseViewController {
    
    @IBOutlet weak var lblNewLocationAddress: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewInfoContainer: UIView!
    @IBOutlet weak var viewDarkFillContainer: CustomView!
    @IBOutlet weak var btnToggle: UIButton!
    
    var latitude : CLLocationDegrees?
    var longitute : CLLocationDegrees?
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        setUp()
    }
    
    func setUp(){
        locationSetUp()
        resultTableRef()
        searchBarSetUp()
    }
    
    func locationSetUp(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            convertLatLongToAddress(latitude: locationManager.location?.coordinate.latitude ?? 19.017615, longitude: locationManager.location?.coordinate.longitude ?? 72.856164)
        }
        
        mapView.isUserInteractionEnabled = true
        mapView.isZoomEnabled = true
        mapView.showsUserLocation = true
    }
    
    func resultTableRef(){
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
    
    func searchBarSetUp(){
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.tintColor = .black
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    func getCoordinte(){
        latitude = locationManager.location?.coordinate.latitude
        longitute = locationManager.location?.coordinate.longitude
    }
    
    @IBAction func onClickToggleBtn(_ sender: Any) {
        
        if viewInfoContainer.transform == .identity{
            UIView.animate(withDuration: 1) {
                self.viewDarkFillContainer.transform = CGAffineTransform(scaleX: 11, y: 11)
                self.viewInfoContainer.transform = CGAffineTransform(translationX: 0, y: 100)
                self.btnToggle.transform = CGAffineTransform(rotationAngle: self.radians(degree: 180))
            }
        }
        else{
            UIView.animate(withDuration: 1) {
                self.viewInfoContainer.transform = .identity
                self.viewDarkFillContainer.transform = .identity
                self.btnToggle.transform = .identity
            }
        }
    }
    
    func radians(degree : CGFloat) -> CGFloat{
        return (degree * .pi / degree)
    }
    
    @IBAction func onClickBack(_ sender: Any){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onclickNext(_ sender: Any) {
        if selectedPin?.coordinate == nil{
            setCurrentLocation(latitute: latitude!, longitute: longitute!)
        }
        else{
            GlobalDataAccess.share.currentLocation.removeAll()
            GlobalDataAccess.share.currentLocation.append(CurrentLocation(latitute: selectedPin!.coordinate.latitude, longitute: selectedPin!.coordinate.longitude))
        }
        let vc = storyboard?.instantiateViewController(identifier: "SelectionViewController") as! SelectionViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placemark: CLPlacemark!
            placemark = placemarks?[0]
            
            self.lblNewLocationAddress.text = "\(placemark.name ?? ""), \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
        })
        
    }
}

extension AddLocationViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first
        {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            latitude = location.coordinate.latitude
            longitute = location.coordinate.longitude
            
            setCurrentLocation(latitute: latitude!, longitute: longitute!)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        AuthorizationSetUp(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error ===== \(error)")
    }
}

extension AddLocationViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        //print("placemark coornidate = \(placemark.coordinate)")
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
            lblNewLocationAddress.text = "\(placemark.name!), \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}



