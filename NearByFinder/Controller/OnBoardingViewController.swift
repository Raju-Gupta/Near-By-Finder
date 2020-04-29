//
//  OnBoardingViewController.swift
//  NearByFinder
//
//  Created by Raju Gupta on 22/03/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit
import paper_onboarding
import RevealingSplashView

class OnBoardingViewController: BaseViewController {
    
    @IBOutlet weak var viewOnboarding: PaperOnboardingView!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashScreenSetUp()
        
        viewOnboarding.delegate = self
        viewOnboarding.dataSource = self
    }
    
    @IBAction func onClickSkip(_ sender: Any)
    {
        //isDoneOnboarding
        UserDefaults.standard.set(true, forKey: "isDoneOnboarding")
        let vc = storyboard?.instantiateViewController(identifier: "RootNavigation") as? UINavigationController
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true, completion: nil)
    }
    @IBAction func onClickDone(_ sender: Any)
    {
        UserDefaults.standard.set(true, forKey: "isDoneOnboarding")
        let vc = storyboard?.instantiateViewController(identifier: "RootNavigation") as? UINavigationController
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true, completion: nil)
    }
}

extension OnBoardingViewController : PaperOnboardingDataSource
{
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "nearbyPlace"), title: "Search Nearby Places", description: "Search nearby places by categories wise like Petrol Pump, ATM, Bank, Hostiptal and many mores.", pageIcon: UIImage(), color: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Heavy", size: 20)!, descriptionFont: UIFont(name: "Avenir-Book", size: 15)!),
                
                OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "address"), title:"Get Object Details", description: "Get selected object details like address, store name and many mores.", pageIcon: UIImage(), color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Heavy", size: 20)!, descriptionFont: UIFont(name: "Avenir-Book", size: 15)!),
                
                OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "navigatePlace"), title: "Get Direction", description: "Get the direction to the selected object like store, petrol pump etc by Google Map App.", pageIcon: UIImage(), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Heavy", size: 20)!, descriptionFont: UIFont(name: "Avenir-Book", size: 15)!)][index]
    }
    
    
}

extension OnBoardingViewController : PaperOnboardingDelegate
{
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2
        {
            btnSkip.isHidden = true
            btnDone.isHidden = false
        }
    }
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index != 2
        {
            if btnDone.isHidden == false
            {
                btnDone.isHidden = true
                btnSkip.isHidden = false
            }
        }
    }
}
