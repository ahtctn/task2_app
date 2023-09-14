//
//  AlarmListBackgroundView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import SwiftUI

struct AlarmListBackgroundView: View {
    @StateObject private var viewModel: AlarmViewModel
    
    init(viewModel: AlarmViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color("orangeColor")
                .frame(width: 410, height: 490, alignment: .center)
                .cornerRadius(20)
            
            Image("bg")
                .resizable()
                .opacity(0.5)
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
                .shadow(color: .black, radius: 10, x: 0, y: 10)
        }
        .opacity(viewModel.isListVisible ? 1.0 : 0.0)
        .animation(.easeInOut(duration: 0.5), value: viewModel.isListVisible)

    }
}

struct AlarmListBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListBackgroundView(viewModel: .init(lnManager: LocalNotificationsManager(), alarms: .constant([Date()])))
    }
}
