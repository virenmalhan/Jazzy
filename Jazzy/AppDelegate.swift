//
//  AppDelegate.swift
//  Jazzy
//
//  Created by Viren Malhan on 07/06/19.
//  Copyright © 2019 Viren Malhan. All rights reserved.
//

import UIKit

/// Application Level delgate class, which handles application delegate methods
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Application window on which root view controller is set
    var window: UIWindow?

    /// Delegate method called when the launch process is almost done and the app is almost ready to run.
    ///
    /// - Parameters:
    ///   - application: application instance
    ///   - launchOptions: options dictionary for application.
    /// - Returns: false if the app cannot handle the URL resource or continue a user activity, otherwise return true
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    /// Delegate method called when the application is about to move from active to inactive state.
    ///
    /// - Parameter application: application instance
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    /// Delegate method called when the application is moved to background.
    ///
    /// - Parameter application: application instance
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    /// Delegate method called when the application is about to come to foreground.
    ///
    /// - Parameter application: application instance
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    /// Delegate method called when the application become active.
    ///
    /// - Parameter application: application instance
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    /// Delegate method called when the application is about to terminate.
    ///
    /// - Parameter application: application instance
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

