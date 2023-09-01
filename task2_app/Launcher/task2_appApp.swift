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
    var body: some Scene {
        WindowGroup {
            //AlarmView(viewModel: AlarmViewModel(lnManager: lnManager))
                //.environmentObject(lnManager)
            ContentView(viewModel: .init(lnManager: lnManager))
                .environmentObject(lnManager)
        }
    }
}
