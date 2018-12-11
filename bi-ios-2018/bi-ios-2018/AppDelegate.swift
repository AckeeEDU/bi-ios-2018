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
        
        let sharedCanvasVC = SharedCanvasViewController()
        sharedCanvasVC.title = "Canvas"
        
        let mapVC = MapViewController()
        mapVC.title = "Map"
        
        let bubblesController = storyboard.instantiateViewController(withIdentifier: "BubblesViewController")
        
        let bubblesNav = UINavigationController(rootViewController: bubblesController)
        bubblesNav.tabBarItem.title = "Bubbles"
        bubblesNav.tabBarItem.image = UIImage(named: "tabbaricon")
        bubblesNav.tabBarItem.badgeValue = "2"
        
        let autolayoutVC = storyboard.instantiateViewController(withIdentifier: "AutolayoutViewController")
        
        let actionsVC = storyboard.instantiateViewController(withIdentifier: "ActionViewController")
        
        let scrollViewController = ScrollViewController()
        scrollViewController.title = "ScrollView"
        
        let tableViewController = TableViewController()
        tableViewController.title = "Table"
        
        let collectionViewController = CollectionViewController()
        collectionViewController.title = "Collection"
        
        let networkTable = NetworkTableViewController()
        networkTable.title = "Network Table"
        
        let tabBarController = UITabBarController()

        tabBarController.viewControllers = [sharedCanvasVC, networkTable, UINavigationController(rootViewController: mapVC), bubblesNav, autolayoutVC, actionsVC, scrollViewController, tableViewController, collectionViewController]
        
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
        
        helloAsyncWorld { (number) in
            print(number)
        }
        
        let method : (Int) -> () = { number in
            print(1)
        }
        
        helloAsyncWorld(callback: method)
        
        helloAsyncWorld(callback: myCallback)
        
        return true
        
    }
    
    func myCallback(number: Int) {
        print(number)
    }
    
    func helloAsyncWorld(callback: (Int) -> ()) {
        callback(1)
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

