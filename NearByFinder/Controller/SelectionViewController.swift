//
//  SelectionViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 02/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import CoreLocation

class SelectionViewController: BaseViewController {
    
    @IBOutlet weak var selectionTableView: UITableView!
    
    let search = UISearchController(searchResultsController: nil)
    var allCategoryData = [Category]()
    var searchOption = [Category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellRegistration()
        searchBarSetUp()
        getCategoryData()
    }
    
    func cellRegistration(){
        let nibName = UINib(nibName: "SelectionCell", bundle: nil)
        selectionTableView.register(nibName, forCellReuseIdentifier: "SelectionCell")
    }
    
    func getCategoryData(){
        DataManager.share.getCategoryData { (categoryInfo) in
            self.allCategoryData = categoryInfo.categories
            self.searchOption = categoryInfo.categories
            DispatchQueue.main.async {
                self.selectionTableView.reloadData()
            }
        }
    }
    
    func searchBarSetUp(){
        self.extendedLayoutIncludesOpaqueBars = true
        search.searchResultsUpdater = self 
        definesPresentationContext = true
        search.searchBar.placeholder = "Search"
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        search.obscuresBackgroundDuringPresentation = false
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}


extension SelectionViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell", for: indexPath) as! SelectionCell
        
        let aCategory = allCategoryData[indexPath.row]
        cell.imgIcon.image = UIImage(named: "\(aCategory.icon)")
        cell.lblName.text = aCategory.name.capitalized
        cell.viewContainer.backgroundColor = UIColor(red: aCategory.red/255, green: aCategory.green/255, blue: aCategory.blue/255, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let aCategory = allCategoryData[indexPath.row]
        GlobalDataAccess.share.attribute.removeAll()
        GlobalDataAccess.share.attribute.append(Attributes(titleStr: aCategory.name, icon: aCategory.icon, red: aCategory.red, green: aCategory.green, blue: aCategory.blue))
        
        let vc = storyboard?.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension SelectionViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        
        if searchText == ""
        {
            allCategoryData = searchOption
        }
        else{
            allCategoryData = searchOption
            allCategoryData = searchOption.filter{($0.name.contains(searchText.lowercased()))}
        }
        selectionTableView.reloadData()
        
    }
    
    
}
