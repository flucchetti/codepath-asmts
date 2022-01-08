//
//  AppDelegate.swift
//  Todo_List_Back4app
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "avg1llwaib3cQWVIexatASAl2ZoH1I1UfEOhPo9Y"
            $0.clientKey = "7pauPcBM4LA6ACSb5dm3MaQmOVKemmZ6bIWx3J0D"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        let installation = PFInstallation.current()
        installation!.saveInBackground()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

