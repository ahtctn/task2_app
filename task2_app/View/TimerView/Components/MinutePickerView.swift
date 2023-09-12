//
//  MinutePickerView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import SwiftUI

struct MinutePickerView: View {
    
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        Picker("Minutes", selection: $viewModel.selectedMinutes) {
            ForEach(0..<60, id: \.self) { minute in
                if minute <= 0 {
                    Text("0\(minute)")
                } else {
                    Text("\(minute)")
                }
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 80)
        .colorInvert()
        .colorMultiply(.white)
        .labelsHidden()
    }
}

struct MinutePickerView_Previews: PreviewProvider {
    static var previews: some View {
        MinutePickerView(viewModel: .init(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])))
    }
}
