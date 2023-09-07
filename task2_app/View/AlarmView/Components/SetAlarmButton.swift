//
//  SetAlarmButton.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct SetAlarmButton: View {
    @StateObject private var viewModel: AlarmViewModel
    @Binding var alarms: [Date]
    init(viewModel: AlarmViewModel, alarms: Binding<[Date]>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._alarms = alarms
    }
    
    var body: some View {
        
        Button("Set Alarm") {
            
            viewModel.setAlarm(alarms: $alarms)
            
            
        }
        
        
        .sheet(item: $viewModel.lnManager.nextView, content: {nextView in
            nextView.view()
        })
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
        .tint(Color("orangeColor"))
        .foregroundColor(.white)
        
    }
    
    
}

struct SetAlarmButton_Previews: PreviewProvider {
    static var previews: some View {
        SetAlarmButton(viewModel: AlarmViewModel(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])), alarms: .constant([.distantFuture]))
            .previewLayout(.sizeThatFits)
    }
}
