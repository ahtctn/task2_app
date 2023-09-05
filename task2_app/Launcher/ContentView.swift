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
                    //Label("Alarm", systemImage: "alarm.fill")
                    VStack {
                        Image(systemName: "alarm.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                        Text("Alarm")
                    }
                }
                .tag(0)
            
            TimerView()
                .tabItem {
                    //Label("Timer", systemImage: "timelapse")
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
        ContentView(viewModel: AlarmViewModel(lnManager: .init()))
    }
}
