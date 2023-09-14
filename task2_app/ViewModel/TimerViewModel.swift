//
//  TimerViewModel.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import Foundation
import UserNotifications
import SwiftUI
import AVFoundation

class TimerViewModel: ObservableObject {
    @Published var scheduleDate = Date()
    @Published var isVisible = false
    @Published var isListVisible = false
    @Published var isGranted = false
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0
    @Published var remainingTime: TimeInterval = 0
    @Published var isTimerRunning = false
    @Published var isShowingCloseCountdownTimerView = false
    private var timer: Timer? = nil
    
    var audioPlayer: AVAudioPlayer?
    
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
                self.playNotificationSound(soundFile: Constants.alarmSound)
                self.isShowingCloseCountdownTimerView = true
                
                print("timer 0 oldur")
                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: self.scheduleDate)
                var localNotification = LocalNotificationModel(identifier: UUID().uuidString,
                                                               title: "Countdown Timer Ended",
                                                               body: "Your countdown timer has reached zero.",
                                                               repeats: false,
                                                               dateComponents: dateComponents,
                                                               notificationSound: Constants.notificationSound)
                localNotification.bundleImageName = Constants.bundleImageName
                localNotification.userInfo = ["nextView": NextView.closeTheAlarm.rawValue]
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        isTimerRunning = false
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    func closeAlarm() {
        stopTimer()
    }
    
    func resetTimer() {
        stopTimer()
        selectedMinutes = 0
        selectedSeconds = 0
        audioPlayer?.stop()
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
            }
        }
    }
    
    func playNotificationSound(soundFile: String) {
        let resourcePath = Bundle.main.url(forResource: soundFile, withExtension: "aiff")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: resourcePath!)
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}
