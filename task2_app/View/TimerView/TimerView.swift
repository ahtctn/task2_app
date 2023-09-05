//
//  TimerView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct TimerView: View {
    @State private var countdownValue: Int = 0
    @State private var isCountingDown: Bool = false
    @State private var countdownTimer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("Countdown: \(countdownValue)")
                .font(.largeTitle)
            
            Button(isCountingDown ? "Stop" : "Start") {
                if isCountingDown {
                    stopCountdown()
                } else {
                    startCountdown()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
    
    private func startCountdown() {
        guard countdownValue > 0 else {
            return // Avoid starting countdown with non-positive value
        }
        
        isCountingDown = true
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdownValue > 0 {
                countdownValue -= 1
            } else {
                stopCountdown()
            }
        }
    }
    
    private func stopCountdown() {
        isCountingDown = false
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
}




struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
