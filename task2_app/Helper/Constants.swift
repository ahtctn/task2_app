//
//  Constants.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import Foundation
import UserNotifications

enum Constants {
    static let alarmSound: String = "alarmSound"
    static let notificationSound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "alarmSound.aiff"))
    static let bundleImageName = "bundleImageName"
    static let closeAlarmViewHourFont1 = "RubikMonoOne-Regular"
    
    static let closeAlarmViewHourFont2 = "Monoton-Regular"
}
