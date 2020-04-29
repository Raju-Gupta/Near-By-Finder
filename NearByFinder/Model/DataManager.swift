//
//  DataManager.swift
//  NearByFinder
//
//  Created by Raju Gupta on 09/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit

class DataManager{
    static let share = DataManager()
    
    func getCategoryData(completion : @escaping (CategoryInfo) -> ())
    {
        if let path = Bundle.main.path(forResource: "categoryData", ofType: "json") {
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let allData: CategoryInfo = try JSONDecoder().decode(CategoryInfo.self, from: data)
                completion(allData)
                
              } catch let err {
                print("error2 \(err.localizedDescription)")
              }
        }
    }
    
    
}
