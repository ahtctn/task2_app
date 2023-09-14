//
//  CloseCountdownTimerView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 14.09.2023.
//

import SwiftUI

struct CloseCountdownTimerView: View {
    var body: some View {
        ZStack {
            Color("orangeColor")
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 10) {
                Text("Close Countdown Timer View")
                    .font(.custom(Constants.closeAlarmViewHourFont1, size: 50))
                Button {
                    print("alarm closed.")
                } label: {
                    
                    Text("close the alarm")
                }

            }
        }
    }
}

struct CloseCountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CloseCountdownTimerView()
    }
}
