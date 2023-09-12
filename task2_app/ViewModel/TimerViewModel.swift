//
//  TimerViewModel.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import Foundation
import UserNotifications
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var scheduleDate = Date()
    @Published var isVisible = false
    @Published var isListVisible = false
    @Published var isGranted = false
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0
    @Published var remainingTime: TimeInterval = 0
    @Published var isTimerRunning = false
    private var timer: Timer? = nil
    
    @Binding var alarms: [Date]
    var lnManager: LocalNotificationsManager
    
    init(lnManager: LocalNotificationsManager, alarms: Binding<[Date]>) {
        self.lnManager = lnManager
        self._alarms = alarms
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
    
    func toggleTimer() {
        if isTimerRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    private func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            stopTimer()
            timerReachedZero(alarms: $alarms)
        }
    }
    
    func startTimer() {
        let totalTime = TimeInterval(selectedMinutes * 60 + selectedSeconds)
        remainingTime = totalTime
        isTimerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                
                self.stopTimer()
                print("timer 0 oldur")
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        isTimerRunning = false
    }
    
    func stopTimer() {
        self.timerReachedZero(alarms: self.$alarms)
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    func resetTimer() {
        stopTimer()
        selectedMinutes = 0
        selectedSeconds = 0
    }
    
    func formattedTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func timerReachedZero(alarms: Binding<[Date]>) {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: scheduleDate)
        var localNotification = LocalNotificationModel(identifier: UUID().uuidString,
                                                       title: "Countdown Timer Ended",
                                                       body: "Your countdown timer has reached zero.",
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
                print("\(alarms) Alarms")
                
                if alarms.isEmpty {
                    print("alarms is empty")
                } else {
                    print("alarms is not empty")
                    
                    for _alarm in _alarms {
                        print("\(_alarm.self)")
                    }
                }
            }
        }
    }
}
