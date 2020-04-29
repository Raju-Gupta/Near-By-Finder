//
//  DirectionViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 02/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import MapKit

class DirectionViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var destintionCoordinate : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mapView.delegate = self
        mapView.showsUserLocation = true
        
        let sourceLocation = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        //print("lat == \(locationManager.location!.coordinate.latitude)")
        let destinationLocation = CLLocationCoordinate2D(latitude:destintionCoordinate!.latitude , longitude: destintionCoordinate!.longitude)
        
        let sourcePin = CustomPin(pinTitle: "Your Location", pinSubtitle: "You are here", location: sourceLocation)
        let destinationPin = CustomPin(pinTitle: "Destination Location", pinSubtitle: "Your Destination", location: destinationLocation)
        
        self.mapView.addAnnotation(sourcePin)
        self.mapView.addAnnotation(destinationPin)
        mapView.showAnnotations([sourcePin,destinationPin], animated: true)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let desnitaionPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlaceMark)
        request.destination = MKMapItem(placemark: desnitaionPlaceMark)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error{
                    print("error = \(error.localizedDescription)")
                }
                return
            }
            
            let route = directionResponse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
    }
    
    
}

extension DirectionViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolygonRenderer(overlay: overlay)
        render.strokeColor = .blue
        render.lineWidth = 4.0
        return render
    }
}


extension DirectionViewController: CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{

            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        AuthorizationSetUp(status: status)
    }
}

class CustomPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title : String?
    var subtitle: String?
    
    init(pinTitle : String, pinSubtitle : String, location : CLLocationCoordinate2D){
        self.coordinate = location
        self.title = pinTitle
        self.subtitle = pinSubtitle
    }
    
}

