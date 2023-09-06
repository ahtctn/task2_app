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
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack {
                Text("Countdown: \(countdownValue)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Button(isCountingDown ? "Stop" : "Start") {
                    if isCountingDown {
                        stopCountdown()
                    } else {
                        startCountdown()
                    }
                }
                .padding()
                .background(Color("orangeColor"))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            //.background(Color("backgroundColor"))
            .background(Color("backgroundColor"), ignoresSafeAreaEdges: .all)
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
