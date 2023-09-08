//
//  PlayPauseButtonView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import SwiftUI

struct PlayPauseButtonView: View {
    
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        Button(viewModel.isTimerRunning ? "Pause" : "Play") {
            viewModel.toggleTimer()
        }
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
        PlayPauseButtonView(viewModel: .init())
    }
}
