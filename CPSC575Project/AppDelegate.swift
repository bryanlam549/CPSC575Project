/*
The AppDelegate will be responsible for the application lifecycle and setup.
The main point of entry for an application.

    3 main functions:
    1. func application(_:didFinishLaunchingWithOptions:) -> Bool
    2. func application(_:configurationForConnecting:options:) -> UISceneConfiguration
    3. func application(_:didDiscardSceneSessions:)
 
AppDelegate can still handle the external services like push notification registrations, location services, app termination and more.
*/


//  AppDelegate.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-09-29.
//  Copyright © 2020 bryan lam. All rights reserved.
//



import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //Desc:
    //This method is called when the application is launched and where the application set-up is done
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    //Desc
    //This method is called when ever the application needs a new scene or window to display.
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    //Desc
    //This method is called when ever user discards a scene like by swiping it from the multitasking window or if discarded programatically.
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

