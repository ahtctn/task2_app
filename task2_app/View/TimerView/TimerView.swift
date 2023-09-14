//
//  TimerView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject var viewModel: TimerViewModel
    @State private var alarms = [Date]()
    
    
    init(viewModel: TimerViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                if viewModel.isShowingCloseCountdownTimerView {
                    CloseCountdownTimerView()
                        .onTapGesture {
                            viewModel.startTimer()
                            viewModel.isShowingCloseCountdownTimerView = false
                        }
                        .transition(.move(edge: .bottom))
                }
                
                Color("backgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    if viewModel.isGranted {
                        CountdownTimerText(viewModel: viewModel)
                        HStack {
                            MinutePickerView(viewModel: viewModel)
                            SecondPickerView(viewModel: viewModel)
                        }
                        PlayPauseButtonView(viewModel: viewModel, alarms: $alarms)
                        SetResetButtonView(viewModel: viewModel)
                    }
                }
            }
            
            .onDisappear {
                viewModel.stopTimer()
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




struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: TimerViewModel(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])))
    }
}
