//
//  DatePickerView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct DatePickerView: View {
    
    @StateObject private var viewModel: AlarmViewModel
    
    init(viewModel: AlarmViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            DatePicker("", selection: $viewModel.scheduleDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .padding(.horizontal)
                .padding(.vertical)
                .colorInvert()
                .colorMultiply(.white)
                .labelsHidden()
            //Spacer()
        }
        
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(viewModel: AlarmViewModel(lnManager: .init(), alarms: .constant([.distantFuture])))
            .previewLayout(.sizeThatFits)
            
    }
}
