//
//  TabBarVC.swift
//  ExpensesTracker
//
//  Created by Artem Sierokurov on 09.11.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dashBoardVC = createNavController(viewController: DashBoardViewController(), title: "DashBoard", image: UIImage(imageLiteralResourceName: "list@3x"))
        let expensesVC = createNavController(viewController: ExpensesViewController(), title: "Expenses", image: UIImage(imageLiteralResourceName: "coins@3x"))
        
        viewControllers = [dashBoardVC, expensesVC]
    }
    
    func createNavController(viewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        viewController.navigationItem.title = title
        navController.tabBarItem.image = image
        tabBar.tintColor = .black
        
        return navController
    }
}
