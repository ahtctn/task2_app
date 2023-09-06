//
//  NextView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 30.08.2023.
//

import SwiftUI

enum NextView: String, Identifiable {
    case closeTheAlarm
    var id: String {
        self.rawValue
    }
    
    @MainActor @ViewBuilder
    func view() -> some View{
        switch self {
         case .closeTheAlarm:
            CloseAlarmView(viewModel: .init(lnManager: LocalNotificationsManager()))
        }
    }
}

