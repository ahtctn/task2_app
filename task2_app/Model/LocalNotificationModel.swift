//
//  LocalNotificationModel.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 30.08.2023.
//

import Foundation
import UserNotifications

struct LocalNotificationModel {
    
    internal init(identifier: String, title: String, body: String, timeInterval: Double, repeats: Bool) {
        self.identifier = identifier
        self.scheduleType = .time
        self.title = title
        self.body = body
        self.timeInterval = timeInterval
        self.repeats = repeats
        self.dateComponents = nil
    }
    internal init(identifier: String, title: String, body: String, repeats: Bool, dateComponents: DateComponents, notificationSound: UNNotificationSound?) {
        self.identifier = identifier
        self.title = title
        self.scheduleType = .calendar
        self.body = body
        self.timeInterval = nil
        self.repeats = repeats
        self.dateComponents = dateComponents
        self.notificationSound = notificationSound
    }
    
    enum ScheduleType {
        case time, calendar
    }
    
    var identifier: String
    var scheduleType: ScheduleType
    var title: String
    var subtitle: String?
    var body: String
    var userInfo: [AnyHashable: Any]?
    var timeInterval: Double?
    var bundleImageName: String?
    var repeats: Bool
    var dateComponents: DateComponents?
    var categoryIdentifier: String?
    var notificationSound: UNNotificationSound?
    
}
