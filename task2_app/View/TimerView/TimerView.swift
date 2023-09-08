//
//  TimerView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 1.09.2023.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
    
            VStack {
                HStack {
                    //MARK: BURASI AYRILACAK. (1)
                    MinutePickerView(viewModel: viewModel)
                    
                    //MARK: BURASI AYRILACAK. (2)
                    SecondPickerView(viewModel: viewModel)
                }
                
                //MARK: BURASI AYRILACAK.(3)
                CountdownTimerText(viewModel: viewModel)
                
                //MARK: BURASI AYRILACAK. (4)
                PlayPauseButtonView(viewModel: viewModel)
                
                //MARK: BURASI AYRILACAK. (5)
                SetResetButtonView(viewModel: viewModel)
            }
        }
        
        .onDisappear {
            viewModel.stopTimer()
        }
    }
}




struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
