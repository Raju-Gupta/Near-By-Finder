//
//  MapResultViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 02/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import MapKit
import PullUpController

class MapResultViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var mapItems = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(GlobalDataAccess.share.attribute[0].titleStr.capitalized)'s"
        AddAnnotation()
        locationSetUp()
        addPullUpVC()
    }
    
    func addPullUpVC(){
        let pullUpController: PullUpViewController = storyboard?.instantiateViewController(withIdentifier: "PullUpViewController") as! PullUpViewController
        pullUpController.mapItems = mapItems
        addPullUpController(pullUpController, initialStickyPointOffset: 50, animated: true)
    }
    
    func locationSetUp(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.isUserInteractionEnabled = true
        mapView.isZoomEnabled = true
        mapView.showsUserLocation = true
        //mapView.userTrackingMode = MKUserTrackingMode
    }
    
//    func setMapRegion(){
//        let centerLocation = CLLocationCoordinate2D(latitude: GlobalDataAccess.share.currentLocation[0].latitute, longitude: GlobalDataAccess.share.currentLocation[0].longitute)
//        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
//        let region = MKCoordinateRegion(center: centerLocation, span: span)
//        mapView.setRegion(region, animated: true)
//    }
    
    
    func AddAnnotation()
    {
        for item in mapItems
        {
            let center = CLLocationCoordinate2D(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
            let selectedItem = item.placemark
            let address = "\(selectedItem.thoroughfare ?? "") \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")"
            
            let annotation = MKPointAnnotation()
            annotation.title = item.name
            annotation.subtitle = address
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
            mapView.showAnnotations([annotation], animated: true)
            mapView.fitAll()
        }
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension MKMapView {
    /// when we call this function, we have already added the annotations to the map, and just want all of them to be displayed.
    func fitAll() {
        var zoomRect            = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect       = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect            = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
    }
    
    /// we call this function and give it the annotations we want added to the map. we display the annotations if necessary
    func fitAll(in annotations: [MKAnnotation], andShow show: Bool) {
        var zoomRect:MKMapRect  = MKMapRect.null
        
        for annotation in annotations {
            let aPoint          = MKMapPoint(annotation.coordinate)
            let rect            = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)
            
            if zoomRect.isNull {
                zoomRect = rect
            } else {
                zoomRect = zoomRect.union(rect)
            }
        }
        if(show) {
            addAnnotations(annotations)
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
    }
    
}
