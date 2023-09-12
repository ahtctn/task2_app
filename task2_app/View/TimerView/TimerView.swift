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
                Color("backgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    if viewModel.isGranted {
                        HStack {
                            //MARK: BURASI AYRILACAK. (1)
                            MinutePickerView(viewModel: viewModel)
                            //MARK: BURASI AYRILACAK. (2)
                            SecondPickerView(viewModel: viewModel)
                        }
                        //MARK: BURASI AYRILACAK.(3)
                        CountdownTimerText(viewModel: viewModel)
                        //MARK: BURASI AYRILACAK. (4)
                        PlayPauseButtonView(viewModel: viewModel, alarms: $alarms)
                        //MARK: BURASI AYRILACAK. (5)
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
