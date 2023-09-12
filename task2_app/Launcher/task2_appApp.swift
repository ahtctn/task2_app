//
//  task2_appApp.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 30.08.2023.
//

import SwiftUI

@main
struct task2_appApp: App {
    @StateObject var lnManager = LocalNotificationsManager()
    @State private var alarms = [Date]()
    
    var body: some Scene {
        WindowGroup {
            
            ContentView(alarmViewModel: AlarmViewModel(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])), timerViewModel: TimerViewModel(lnManager: lnManager, alarms: .constant([.distantFuture])))
                .environmentObject(lnManager)
        }
    }
}
