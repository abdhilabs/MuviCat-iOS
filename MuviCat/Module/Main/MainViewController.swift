//
//  ViewController.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Navigation
    private lazy var home: UIViewController = {
        let vc = HomeViewController()
        let image = UIImage(systemName: "house")
        let selectedImage = UIImage(systemName: "house.fill")
        vc.tabBarItem = UITabBarItem(title: "Home", image: image, selectedImage: image)
        return UINavigationController(rootViewController: vc)
    }()
    
    private lazy var search: UIViewController = {
        let vc = SearchViewController()
        let image = UIImage(systemName: "rosette")
        let selectedImage = UIImage(systemName: "rosette")
        vc.tabBarItem = UITabBarItem(title: "Search", image: image, selectedImage: selectedImage)
        return UINavigationController(rootViewController: vc)
    }()
    
    private lazy var favourite: UIViewController = {
        let vc = FavoriteViewController()
        let image = UIImage(systemName: "heart")
        let selectedImage = UIImage(systemName: "heart.fill")
        vc.tabBarItem = UITabBarItem(title: "Favorite", image: image, selectedImage: selectedImage)
        return UINavigationController(rootViewController: vc)
    }()
    
    private lazy var profile: UIViewController = {
        let vc = ProfileViewController()
        let image = UIImage(systemName: "person.circle")
        let selectedImage = UIImage(systemName: "person.circle.fill")
        vc.tabBarItem = UITabBarItem(title: "Profile", image: image, selectedImage: selectedImage)
        return UINavigationController(rootViewController: vc)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.isOpaque = false
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = UIColor.tabIconColor
        
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 0.3
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tabBar.layer.shadowRadius = 2
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.layer.cornerRadius = 4
        self.tabBar.clipsToBounds = true
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tabBar.backgroundColor = UIColor.tabColor
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        self.viewControllers = [home, search, favourite, profile]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


}

