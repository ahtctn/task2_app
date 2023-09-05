//
//  ContentView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 30.08.2023.
//

import SwiftUI

struct AlarmView: View {
    @StateObject private var viewModel: AlarmViewModel

    init(viewModel: AlarmViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {

        NavigationView {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea(.all)
                VStack(alignment: .center, spacing: 10) {
                    if viewModel.isGranted {
                        DatePickerView(viewModel: viewModel)
                        SetAlarmButton(viewModel: viewModel)
                        
                        if viewModel.isVisible {
                            AlarmSetText(viewModel: viewModel)
                        }
                    }
                }
                .navigationTitle("Alarm")
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
        AlarmView(viewModel: AlarmViewModel(lnManager: LocalNotificationsManager()))
    }
}
