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
    @StateObject private var timerViewModel: TimerViewModel

    let navigationTitleColor = Color("orangeColor")
    
    init(alarmViewModel: AlarmViewModel, timerViewModel: TimerViewModel) {
        self._alarmViewModel = StateObject(wrappedValue: alarmViewModel)
        self._timerViewModel = StateObject(wrappedValue: timerViewModel)
        
        let uiColor = UIColor(navigationTitleColor)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UITabBar.appearance().unselectedItemTintColor = .white
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                AlarmView(viewModel: alarmViewModel)
                    .navigationBarTitle("Alarm", displayMode: .inline)
            }
            
            .tabItem {
                VStack {
                    Image(systemName: "alarm.fill")
                        .font(.title)
                        .foregroundColor(.orange)
                    Text("Alarm")
                }
            }
            .tag(0)
            .toolbarBackground(Color.red, for: .tabBar)
            
            NavigationView {
                TimerView(viewModel: timerViewModel)
                    .navigationBarTitle("Timer", displayMode: .inline)
            }
            .tabItem {
                VStack {
                    Image(systemName: "timelapse")
                        .font(.title)
                        .foregroundColor(.orange)
                    Text("Timer")
                }
            }
            .tag(1)
        }
        .accentColor(Color("orangeColor"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(alarmViewModel: AlarmViewModel(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])), timerViewModel: TimerViewModel(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])))
    }
}
