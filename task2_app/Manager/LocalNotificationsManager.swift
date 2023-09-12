//
//  LocalNotificationsManager.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 30.08.2023.
//

import Foundation
import UserNotifications

@MainActor
class LocalNotificationsManager: NSObject, ObservableObject {
    let notificationCenter = UNUserNotificationCenter.current()
    @Published var isGranted = false
    @Published var pendingRequests: [UNNotificationRequest] = []
    @Published var nextView: NextView?
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    func requestAuthorization() async throws {
        try await notificationCenter.requestAuthorization(options: [.sound, .badge, .alert])
        await getCurrentSettings()
    }
    
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
    }
    
    func schedule(localNotification: LocalNotificationModel) async {
        let content = UNMutableNotificationContent()
        content.title = localNotification.title
        content.body = localNotification.body
        
        if let subtitle = localNotification.subtitle {
            content.subtitle = subtitle
        }
        
        if let userInfo = localNotification.userInfo {
            content.userInfo = userInfo
        }
        
        if let categoryIdentifier = localNotification.categoryIdentifier {
            content.categoryIdentifier = categoryIdentifier
        }
        
        if let notificationSound = localNotification.notificationSound {
            content.sound = notificationSound
        }
        
        if let bundleImageName = localNotification.bundleImageName {
            if let url = Bundle.main.url(forResource: bundleImageName, withExtension: "") {
                if let attachment = try? UNNotificationAttachment(identifier: bundleImageName, url: url) {
                    content.attachments = [attachment]
                }
            }
        }
        
        if localNotification.scheduleType == .time {
            guard let timeInterval = localNotification.timeInterval else { return }
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: localNotification.repeats)
            
            let request = UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: trigger)
            
            try? await notificationCenter.add(request)
            print("yok bura girdi")
        } else if localNotification.scheduleType == .calendar{
            guard let dateComponents = localNotification.dateComponents else { return }
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: localNotification.repeats)
            
            let request = UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: trigger)
            
            try? await notificationCenter.add(request)
            print("bura girdi")
        }
        
        await getPendingRequests()
    }
    
    func getPendingRequests() async {
        pendingRequests = await notificationCenter.pendingNotificationRequests()
    }
    
    func deleteNotificationRequest(withIdentifier identifier: String) async {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        await getPendingRequests()
    }
}

extension LocalNotificationsManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return await withUnsafeContinuation { continuation in
            continuation.resume(returning: [.sound, .banner])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if let value = response.notification.request.content.userInfo["nextView"] as? String {
            nextView = NextView(rawValue: value)
        }
    }
}
