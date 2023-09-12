//
//  SetResetButtonView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import SwiftUI

struct SetResetButtonView: View {
    
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        Button("Set/Reset") {
            if viewModel.isTimerRunning {
                viewModel.toggleTimer()
            } else {
                viewModel.resetTimer()
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
        .tint(Color("secondaryBackgroundColor"))
        .foregroundColor(.white)
        .fontWeight(.bold)
    }
}

struct SetResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SetResetButtonView(viewModel: .init(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])))
    }
}
