//
//  AppDelegate.swift
//  ??
//
//  Created by Роман on 03.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = UITabBarController()
        let assemblyBuilder = ModuleBuilder()
        let router = Router(tabBarController: tabBarController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

