//
//  MainViewController.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 16/03/22.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAppearance()
        setupTabs()
    }
    
    private func setupAppearance() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .red
        tabBar.barTintColor = .systemBackground
        tabBar.backgroundColor = .systemBackground
    }

    private func setupTabs() {
        let homeNav = createTabItem(named: "Home", image: UIImage(systemName: "house"), controlledBy: createHomeTab())
        let cartNav = createTabItem(named: "Cart", image: UIImage(systemName: "cart"), controlledBy: UIViewController())
        let youNav = createTabItem(named: "You", image: UIImage(systemName: "person"), controlledBy: UIViewController())
        
        viewControllers = [homeNav, cartNav, youNav]
    }
    
    private func createTabItem(named name: String, image: UIImage?, controlledBy controller: UIViewController) -> UINavigationController {
        controller.view.backgroundColor = .systemBackground
        
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem.title = name
        nav.tabBarItem.image = image
        
        return nav
    }
    
    private func createHomeTab() -> UIViewController {
        let homeVC = SDUIViewController(url: "home")
        homeVC.title = "Home"
        return homeVC
    }
}
