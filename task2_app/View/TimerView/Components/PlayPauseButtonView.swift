//
//  PlayPauseButtonView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import SwiftUI

struct PlayPauseButtonView: View {
    
    @StateObject var viewModel: TimerViewModel
    @Binding var alarms: [Date]
    
    init(viewModel: TimerViewModel, alarms: Binding<[Date]>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._alarms = alarms
    }
    
    var body: some View {
        Button(viewModel.isTimerRunning ? "Pause" : "Play") {
            viewModel.toggleTimer()
            viewModel.timerReachedZero(alarms: $alarms)
        }
        
        .sheet(item: $viewModel.lnManager.nextView, content: { nextView in
            nextView.view()
        })
        
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
        .tint(Color("greenColor"))
        .foregroundColor(.white)
        .fontWeight(.bold)
    }
}

struct PlayPauseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButtonView(viewModel: .init(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])), alarms: .constant([.distantFuture]))
    }
}
