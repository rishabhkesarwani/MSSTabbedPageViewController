//
//  TabViewController.swift
//  Paged Tabs Example
//
//  Created by Merrick Sapsford on 04/05/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

import UIKit
import MSSTabbedPageViewController

class TabViewController: MSSTabbedPageViewController {
    
    @IBAction func menuButtonAction(_ sender: Any) {
        self.slideMenuController()?.openRight()
    }
    
    // MARK: MSSPageViewControllerDataSource
    
    override func viewControllers(for pageViewController: MSSPageViewController) -> [UIViewController]? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let viewControllers = [storyboard.instantiateViewController(withIdentifier: "ChildViewController"),
                               storyboard.instantiateViewController(withIdentifier: "ChildViewController"),
                               storyboard.instantiateViewController(withIdentifier: "ChildViewController")]
        return viewControllers
    }
    
    // MARK: MSSTabBarViewDataSource
    
    override func tabBarView(_ tabBarView: MSSTabBarView, populateTab tab: MSSTabBarCollectionViewCell, at index: Int) {
        
        tab.title = tabTitles(for: index)
    }
    
    func tabTitles(for index: Int) -> String {
        let tabTitles = [
            "Regular Cleaning",
            "Deep Cleaning",
            "Subscription"
        ]
        
        return tabTitles[index]
    }
}
