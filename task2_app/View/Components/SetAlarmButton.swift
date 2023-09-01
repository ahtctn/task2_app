//
//  SetAlarmButton.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct SetAlarmButton: View {
    @StateObject private var viewModel: AlarmViewModel
    
    init(viewModel: AlarmViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Button("Set Alarm") {
            viewModel.setAlarm()
        }

        .sheet(item: $viewModel.lnManager.nextView, content: {nextView in
            nextView.view()
        })
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
        .tint(.orange)
    }
}

struct SetAlarmButton_Previews: PreviewProvider {
    static var previews: some View {
        SetAlarmButton(viewModel: AlarmViewModel(lnManager: LocalNotificationsManager()))
            .previewLayout(.sizeThatFits)
    }
}
