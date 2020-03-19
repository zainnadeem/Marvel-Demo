//
//  AppDelegate.swift
//  Marvel-Demo
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright © 2020 Zain Nadeem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UINavigationController(rootViewController: DetailViewController())
            navigationController.navigationBar.backgroundColor = UIColor.init(red: 32/255, green: 33/255, blue: 34/255, alpha: 1)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()

        MarvelAPICall.shared.requestAllComics { (any) in
            
        }
   
        return true
    }



}

