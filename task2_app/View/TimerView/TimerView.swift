//
//  TimerView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct TimerView: View {
    @State private var targetDate = Date()
    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("Geri Sayım")
                .font(.largeTitle)
            
            DatePicker("Hedef Tarih Seçin", selection: $targetDate, in: Date()..., displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
            
            
            
            Text("Kalan Süre:")
                .font(.headline)
            
            Text(timeFormatted(remainingTime))
                .font(.largeTitle)
                .onAppear {
                    startTimer()
                }
            
            Button("Sıfırla") {
                stopTimer()
                remainingTime = 0
            }
        }
        .padding()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let now = Date()
            remainingTime = targetDate.timeIntervalSince(now)
            if remainingTime <= 0 {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func timeFormatted(_ seconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: seconds) ?? "00:00:00"
    }
}




struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
