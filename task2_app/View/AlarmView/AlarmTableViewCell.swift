//
//  AlarmTableViewCell.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 6.09.2023.
//

import SwiftUI

struct AlarmTableViewCell: View {
    
    @State private var isOn = false
    
    var body: some View {
        HStack {
            Text("10.15 AM")
                .font(.custom(Constants.closeAlarmViewHourFont2, size: 30))
                .foregroundColor(.white)
            
            Spacer()
            
            Toggle("Set", isOn: $isOn)
                .toggleStyle(.button)
                .tint(Color("orangeColor"))
        }
        .background(Color("secondaryBackgroundColor"))
                
    }
}

struct AlarmTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        AlarmTableViewCell()
            .previewLayout(.sizeThatFits)
    }
}
