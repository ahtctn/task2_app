//
//  TimerViewModel.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import Foundation

class TimerViewModel: ObservableObject {
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0
    @Published var remainingTime: TimeInterval = 0
    @Published var isTimerRunning = false
    private var timer: Timer? = nil
    
    func toggleTimer() {
        if isTimerRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    func startTimer() {
        let totalTime = TimeInterval(selectedMinutes * 60 + selectedSeconds)
        remainingTime = totalTime
        isTimerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stopTimer()
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        isTimerRunning = false
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    func resetTimer() {
        stopTimer()
        selectedMinutes = 0
        selectedSeconds = 0
    }
    
    func formattedTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

}
