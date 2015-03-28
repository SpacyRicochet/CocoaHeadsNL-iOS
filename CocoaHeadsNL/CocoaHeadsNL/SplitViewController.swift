//
//  SplitViewController.swift
//  CocoaHeadsNL
//
//  Created by Bart Hoffman on 14/03/15.
//  Copyright (c) 2015 Stichting CocoaheadsNL. All rights reserved.
//

import Foundation
import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    private var collapseDetailViewController = true
    var selectedObject: PFObject?

    override func viewDidLoad() {
        self.delegate = self
        self.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        if let primaryTab = primaryViewController as? UITabBarController {
            if let primaryNav = primaryTab.selectedViewController as? UINavigationController {
                if let secondaryNav = secondaryViewController as? UINavigationController {
                    for item in secondaryNav.viewControllers {
                        if let viewController = item as? UIViewController {
                            if let detailVC = viewController as? DetailTableViewController {
                                primaryNav.showViewController(detailVC, sender: self)
                            }
                        }
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
        
        if let tabBarViewController = primaryViewController as? UITabBarController {
            if let navigationController = tabBarViewController.selectedViewController as? UINavigationController {
                if navigationController.childViewControllers.count > 1 {
                    let poppedControllers = navigationController.popToRootViewControllerAnimated(false)
                    let childNavigationController = UINavigationController()
                    childNavigationController.viewControllers = poppedControllers
                    
                    return childNavigationController
                }
            }
        }
        
        return nil
    }
    

    func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
        
        if splitViewController.collapsed {
            if let master = splitViewController.viewControllers[0] as? UITabBarController {
                if let masterNavigation = master.selectedViewController as? UINavigationController {
            
                    masterNavigation.showViewController(vc, sender: self)
            
                    return true
                }
            }
        } else {
            if let masterNavigation = splitViewController.viewControllers[1] as? UINavigationController {
                masterNavigation.setViewControllers([vc], animated: true)
                
                return true
            }
        }

        return false
    }

}
