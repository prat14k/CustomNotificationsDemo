//
//  AppDelegate.swift
//  CustomNotificationsDemo
//
//  Created by Prateek Sharma on 7/10/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
}

extension AppDelegate {
    
    func registerNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] (isGranted, error) in
            print(isGranted)
            DispatchQueue.main.async {
                if isGranted {
                    self?.getNotificationSettings()
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
            print(settings)
        })
    }
}

