//
//  CountdownTimerText.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 8.09.2023.
//

import SwiftUI

struct CountdownTimerText: View {
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        ZStack {
            Color("orangeColor")
                .frame(width: 200, height: 100, alignment: .center)
                .cornerRadius(10)
                
            Text(viewModel.formattedTime(viewModel.remainingTime))
                .font(.custom(Constants.closeAlarmViewHourFont1, size: 40))
                .foregroundColor(.white)
                .animation(.easeInOut(duration: 0.5))
        }
    }
}

struct CountdownTimerText_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerText(viewModel: .init(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])))
    }
}
