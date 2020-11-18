/*The SceneDelegate will be responsible for what is shown on the screen (Windows or Scenes) handle and manage the way your app is shown. (Windows or Scenes) handle and manage the way your app is shown.
 
 6 Important methods

     1. scene(_:willConnectTo:options:)
        -This method will creates new UIWindow, sets the root view controller and makes this window the key window to be displayed.
     2. sceneDidDisconnect(_:)
        -This is the interesting method of all the methods. When ever the scene is sent to background, iOS might decide to completely discard the scene to free up the resources. This doesn’t meant that the app is killed or not running, but just the scene is disconnected from the session and is not active. iOS can decide to reconnect back this scene to scene session when the user brings that particular scene to foreground again . This method can be used to discard any resources that aren’t used anymore.
     3. sceneDidBecomeActive(_:) & sceneDidEnterBackground(_:)
        -This method is called right after the WillEnterForeground method and here the scene is set-up and visible and ready to use.
     4. sceneWillResignActive(_:)
        -These methods are called when app stages to backgground .
     5. sceneWillEnterForeground(_:)
        -This method is called when the scene is about to start like when app becomes active for the first time or when transitions from background to foreground.

     
*/

//  SceneDelegate.swift
//  CPSC575Project
//
//  Created by bryan lam on 2020-09-29.
//  Copyright © 2020 bryan lam. All rights reserved.

import UIKit
import SwiftUI
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var model = LoginSignUpModel()
    //var chatController = VMChatRow()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        let obs = observer()
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(model).environmentObject(obs))//.environmentObject(chatController))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

