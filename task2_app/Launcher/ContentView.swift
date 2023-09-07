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
    let navigationTitleColor = Color("orangeColor")
    
    init(viewModel: AlarmViewModel) {
        self._alarmViewModel = StateObject(wrappedValue: viewModel)
        
        let uiColor = UIColor(navigationTitleColor)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UITabBar.appearance().unselectedItemTintColor = .white
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                AlarmView(viewModel: alarmViewModel)
                    .navigationBarTitle("Alarm Title", displayMode: .inline)
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
                TimerView()
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
        ContentView(viewModel: AlarmViewModel(lnManager: .init(), alarms: .constant([.distantFuture])))
    }
}
