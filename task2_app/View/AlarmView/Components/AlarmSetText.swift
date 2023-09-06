//
//  AlarmSetText.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct AlarmSetText: View {
    @StateObject private var viewModel: AlarmViewModel
    
    init(viewModel: AlarmViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(viewModel.setAlarmText())
            .foregroundColor(Color("orangeColor"))
            .opacity(viewModel.isVisible ? 1.0 : 0.0)
            .transition(.opacity)
    }
}

struct AlarmSetText_Previews: PreviewProvider {
    static var previews: some View {
        AlarmSetText(viewModel: AlarmViewModel(lnManager: .init()))
            .previewLayout(.sizeThatFits)
    }
}
