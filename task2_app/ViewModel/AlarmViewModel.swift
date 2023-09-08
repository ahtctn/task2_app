//
//  AlarmViewModel.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import Foundation
import UserNotifications
import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var scheduleDate = Date()
    @Published var isVisible = false
    @Published var isGranted = false
    @Published var isListVisible = false
    @Binding var alarms: [Date]
    
    var lnManager: LocalNotificationsManager
    
    init(lnManager: LocalNotificationsManager, alarms: Binding<[Date]>) {
        self.lnManager = lnManager
        self._alarms = alarms
    }
    
    func setAlarm(alarms: Binding<[Date]>) {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduleDate)
        var localNotification = LocalNotificationModel(identifier: UUID().uuidString,
                                                       title: "Wake Up",
                                                       body: "It's time to start a new day.",
                                                       repeats: false,
                                                       dateComponents: dateComponents,
                                                       notificationSound: Constants.notificationSound)
        localNotification.bundleImageName = Constants.bundleImageName
        localNotification.userInfo = ["nextView": NextView.closeTheAlarm.rawValue]
        
        let copiedNotification = localNotification
        Task {
            await lnManager.schedule(localNotification: copiedNotification)
            DispatchQueue.main.async {
                self.isVisible = true
                self.isListVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                withAnimation {
                    self.isVisible = false
                }
            }
            
            withAnimation {
                alarms.wrappedValue.append(self.scheduleDate)
            }
        }
    }
    
    func setAlarmText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let alarmTimeString = dateFormatter.string(from: scheduleDate)
        return "Alarm set to \(alarmTimeString) successfully!"
    }
    
    func requestAuthorization() {
        Task {
            do {
                try await lnManager.requestAuthorization()
                DispatchQueue.main.async {
                    self.isGranted = self.lnManager.isGranted
                }
            } catch {
                print("Authorization request failed: \(error)")
            }
        }
    }
    
    func getCurrentSettings() async {
        await lnManager.getCurrentSettings()
    }
    
    func getPendingRequests() async {
        await lnManager.getPendingRequests()
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets.reversed() {
            if index < alarms.count && index >= 0 {
                let identifier = alarms[index].description
                alarms.remove(at: index)
                
                Task {
                    await lnManager.deleteNotificationRequest(withIdentifier: identifier)
                }
            }
        }
    }
    
}
