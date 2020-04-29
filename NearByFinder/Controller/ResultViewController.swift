//
//  ResultViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 02/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ResultViewController: UIViewController {

    @IBOutlet weak var resultTableView: UITableView!
    var mapItems = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(GlobalDataAccess.share.attribute[0].titleStr.capitalized)'s"
        cellRegitration()
        getAllResult()
    }
    
    func cellRegitration(){
        let nibName = UINib(nibName: "ResultCell", bundle: nil)
        resultTableView.register(nibName, forCellReuseIdentifier: "ResultCell")
    }
    
    func getAllResult()
    {
        let currentLocation = GlobalDataAccess.share.currentLocation[0]
        let centerLocation = CLLocationCoordinate2D(latitude: currentLocation.latitute, longitude: currentLocation.longitute)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: centerLocation, span: span)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = GlobalDataAccess.share.attribute[0].titleStr
        request.region = region
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if error != nil
            {
                print("error===\(error!.localizedDescription)")
            }
            else{
                self.mapItems = response!.mapItems
                self.resultTableView.reloadData()
            }
        }
    }

    @IBAction func onClickMapBtn(_ sender: Any) {
        let mapVc = storyboard?.instantiateViewController(identifier: "MapResultViewController") as! MapResultViewController
        mapVc.mapItems = mapItems
        navigationController?.pushViewController(mapVc, animated: true)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ResultViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        
        let selectedItem = mapItems[indexPath.row].placemark
        let attribute = GlobalDataAccess.share.attribute[0]
        let address = "\(selectedItem.thoroughfare ?? "") \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")"
        
        cell.lblTitleResult.text = mapItems[indexPath.row].name
        cell.lblSubTitleResult.text = address
        cell.imgResult.image = UIImage(named: attribute.icon)
        cell.viewContainer.backgroundColor = UIColor(red: attribute.red/255, green: attribute.green/255, blue: attribute.blue/255, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = mapItems[indexPath.row]
        
        var url : String?
        if let confirm = selectedItem.url{
            url = "\(confirm)"
        }
        
        GlobalDataAccess.share.singleItem.removeAll()
        GlobalDataAccess.share.singleItem.append(SingleItemInfo(name: selectedItem.name ?? "", phone: selectedItem.phoneNumber ?? "", url: url ?? "", placemark: selectedItem.placemark, coordinate: selectedItem.placemark.coordinate))
        
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
