//
//  AlarmTableViewCell.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 6.09.2023.
//

import SwiftUI

struct AlarmTableViewCell: View {
    
    @State private var isOn = false
    var alarmDate: Date
    
    var body: some View {
        HStack {
            Text(formatDate(alarmDate))
                .font(.custom(Constants.closeAlarmViewHourFont2, size: 30))
                .foregroundColor(.white)
            
            Spacer()
            
            Toggle("Set", isOn: $isOn)
                .toggleStyle(.button)
                .tint(Color("orangeColor"))
        }
        .background(Color("secondaryBackgroundColor"))
                
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}

struct AlarmTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        AlarmTableViewCell(alarmDate: Date())
            .previewLayout(.sizeThatFits)
    }
}
