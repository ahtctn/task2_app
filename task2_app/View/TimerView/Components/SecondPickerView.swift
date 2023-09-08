//
//  SecondPickerView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import SwiftUI

struct SecondPickerView: View {
    
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        HStack {
            Text(":")
                .foregroundColor(.white)
            Picker("Seconds", selection: $viewModel.selectedSeconds) {
                ForEach(0..<60, id: \.self) { second in
                    if second <= 9 {
                        Text("0\(second)")
                    } else {
                        Text("\(second)")
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
}

struct SecondPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SecondPickerView(viewModel: .init())
            .previewLayout(.sizeThatFits)
    }
}
