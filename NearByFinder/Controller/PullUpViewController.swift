//
//  PullUpViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 12/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import PullUpController
import MapKit

class PullUpViewController: PullUpController {
    
    var mapItems = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PullUpViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selectedItem = mapItems[indexPath.row].placemark
        
        let address = "\(selectedItem.thoroughfare ?? "") \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")"
        
        cell.textLabel?.text = mapItems[indexPath.row].name
        cell.detailTextLabel?.text = address
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
    
    
}
