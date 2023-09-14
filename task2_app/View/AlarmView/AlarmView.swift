//
//  ContentView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 30.08.2023.
//

import SwiftUI

struct AlarmView: View {
    @StateObject private var viewModel: AlarmViewModel
    @State private var alarms = [Date]()
    @State private var isShowingAlarmList = false
    
    
    init(viewModel: AlarmViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea(.all)
                if viewModel.isGranted {
                    
                    VStack(alignment: .center, spacing: 10) {
                        Spacer()
                        DatePickerView(viewModel: viewModel)
                            .labelsHidden()
                        SetAlarmButton(viewModel: viewModel, alarms: $alarms)
                        
                        if viewModel.isVisible {
                            AlarmSetText(viewModel: viewModel)
                        }
                        
                        ZStack {
                            if alarms.count > 0 {
                                AlarmListBackgroundView(viewModel: viewModel)
                                
                                List {
                                    ForEach(alarms, id: \.self) { alarm in
                                        AlarmTableViewCell(alarmDate: alarm)
                                            .listRowBackground(Color("secondaryBackgroundColor"))
                                    }
                                    .onDelete(perform: viewModel.deleteItem(at:))
                                }
                                .transition(.opacity)
                                .opacity(viewModel.isListVisible ? 1.0 : 0.0)
                                .animation(.easeInOut(duration: 1.0), value: viewModel.isListVisible)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        Spacer()
                    }
                }
                
            }
        }
        .navigationViewStyle(.stack)
        .task {
            viewModel.requestAuthorization()
            await viewModel.getCurrentSettings()
            await viewModel.getPendingRequests()
        }
    }
}


struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(viewModel: AlarmViewModel(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])))
    }
}
