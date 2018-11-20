//
//  AppDelegate.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 16.10.18.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = .red
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bubblesController = storyboard.instantiateViewController(withIdentifier: "BubblesViewController")
        
        let bubblesNav = UINavigationController(rootViewController: bubblesController)
        bubblesNav.tabBarItem.title = "Bubbles"
        bubblesNav.tabBarItem.image = UIImage(named: "tabbaricon")
        bubblesNav.tabBarItem.badgeValue = "2"
        
        let scrollViewController = ScrollViewController()
        
        let tableViewController = CollectionViewController()
        
        
        let viewController2 = storyboard.instantiateViewController(withIdentifier: "AutolayoutViewController")
        let viewController3 = storyboard.instantiateViewController(withIdentifier: "AutolayoutViewController")
        let viewController4 = storyboard.instantiateViewController(withIdentifier: "AutolayoutViewController")
        let viewController5 = storyboard.instantiateViewController(withIdentifier: "AutolayoutViewController")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [bubblesNav, scrollViewController, viewController2, viewController3, viewController4, viewController5]
        
//        window?.rootViewController = tabBarController
        window?.rootViewController = tableViewController
        
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

