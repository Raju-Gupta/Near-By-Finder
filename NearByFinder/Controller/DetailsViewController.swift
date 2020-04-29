//
//  DetailsViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 02/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var viewContainer: CustomView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWebsiteUrl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var aItem : SingleItemInfo!
    var attribute : Attributes!
    var address : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUp()
        DataSetUp()
        AddAnnotation()
        
    }
    
    func SetUp(){
        aItem = GlobalDataAccess.share.singleItem[0]
        attribute = GlobalDataAccess.share.attribute[0]
        address = "\(aItem.placemark.thoroughfare ?? "") \(aItem.placemark.locality ?? ""), \(aItem.placemark.subLocality ?? ""), \(aItem.placemark.administrativeArea ?? ""), \(aItem.placemark.postalCode ?? ""), \(aItem.placemark.country ?? "")"
    }
    
    func DataSetUp(){
        
        lblTitle.text = aItem.name
        lblPhone.text = aItem.phone
        lblAddress.text = address
        lblWebsiteUrl.text = aItem.url
        
        viewContainer.backgroundColor = UIColor(red: attribute.red/255, green: attribute.green/255, blue: attribute.blue/255, alpha: 1)
        imgSelected.image = UIImage(named: attribute.icon)
    }
    
    func AddAnnotation(){
        let center = CLLocationCoordinate2D(latitude: aItem.coordinate.latitude, longitude: aItem.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.title = aItem.name
        annotation.subtitle = address
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
    }

    @IBAction func onClickStartNavigation(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "DirectionViewController") as! DirectionViewController
        vc.destintionCoordinate = aItem.coordinate
        navigationController?.pushViewController(vc, animated: true)
    }
}
