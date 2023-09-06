//
//  CloseAlarmViewModel.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 6.09.2023.
//

import Foundation
import SwiftUI

class CloseAlarmViewModel: ObservableObject {
    
    @Published var scheduleDate = Date()
    var lnManager: LocalNotificationsManager
    
    init(lnManager: LocalNotificationsManager) {
        self.lnManager = lnManager
    }
    
    func setHourTitle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let hourString = dateFormatter.string(from: scheduleDate)
        return hourString
    }
}
