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
}
