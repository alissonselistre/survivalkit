//
//  NotificationHelper.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit
import UserNotifications

struct NotificationHelper {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in }
    }

    static func generateNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Cara!"
        content.body = "Clica em mim pois eu acho que tu esqueceu uma bagaça..."
        content.sound = .default()

        let request = UNNotificationRequest(identifier: "Reminder", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
