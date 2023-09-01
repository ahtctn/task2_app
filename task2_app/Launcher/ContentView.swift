//
//  ContentView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    @StateObject private var alarmViewModel: AlarmViewModel

    init(viewModel: AlarmViewModel) {
        self._alarmViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AlarmView(viewModel: alarmViewModel)
                .tabItem {
                    Label("Alarm", systemImage: "alarm.fill")
                }
                .tag(0)
            
            TimerView()
                .tabItem {
                    Label("Timer", image: "clock.fill")
                }
                .tag(1)
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: AlarmViewModel(lnManager: .init()))
    }
}
