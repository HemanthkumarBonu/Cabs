//
//  AppDelegate.swift
//  Cabs
//
//  Created by Hemanth kumar  on 14/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())

        return true
    }

}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return nil
        }
        return nil
    }
    
    func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    

}
