//
//  AppDelegate.swift
//  CustomNotificationsDemo
//
//  Created by Prateek Sharma on 7/10/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit
import UserNotifications

var logData: String = "Log Data"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var timer: Timer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Did Finish Launch")
        logData += "\nDid Finish Launch"
        NotificationManager.shared.requestNotificationAuth()
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
            print(logData)
        }
        
        return true
    }
    
    
}

extension AppDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationManager.shared.didRecieve(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NotificationManager.shared.didFailToRegister(error: error)
    }
}
