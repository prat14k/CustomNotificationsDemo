//
//  NotificationManager.swift
//  CustomNotificationsDemo
//
//  Created by Prateek Sharma on 7/10/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
    private var token: String?
    private var center: UNUserNotificationCenter {
        return UNUserNotificationCenter.current()
    }

}

extension NotificationManager {
    
    func didRecieve(deviceToken: Data) {
        token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print(token ?? "nil")
    }
    
    func didFailToRegister(error: Error) {
        print(error)
    }
    
    func requestNotificationAuth() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] (isGranted, error) in
            print("APNS Request Successful: \(isGranted)")
            DispatchQueue.main.async {
                if isGranted {
                    self?.registerForNotifications()
                    self?.getNotificationSettings()
                }
            }
        }
    }
    
    private func registerForNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
        center.delegate = self
        let notifAction = UNNotificationAction(identifier: "action1", title: "Action 1", options: [.foreground])
        let category = UNNotificationCategory(identifier: "category", actions: [notifAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: nil, categorySummaryFormat: nil, options: [])
        center.setNotificationCategories(Set([category]))
    }
    
    func getNotificationSettings() {
        center.getNotificationSettings(completionHandler: { (settings) in
            print(settings)
        })
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Method=  didReceive:withCompletionHandler:")
        logData += "\ndidReceive:withCompletionHandler:"
        print(response.actionIdentifier)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Will present Notif; State: Active")
        logData += "\nWill present Notif; State: Active"
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("Method=  openSettingsFor:")
        logData += "\nopenSettingsFor:"
    }
}
