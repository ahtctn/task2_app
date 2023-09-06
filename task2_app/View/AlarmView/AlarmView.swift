//
//  ContentView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 30.08.2023.
//

import SwiftUI

struct AlarmView: View {
    @StateObject private var viewModel: AlarmViewModel
    
    init(viewModel: AlarmViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea(.all)
                VStack(alignment: .center, spacing: 10) {
                    if viewModel.isGranted {
                        //MARK: VSTACK BUNUN İÇERİSİNE EKLENECEK.
                    }
                    Spacer()
                    DatePickerView(viewModel: viewModel)
                        .labelsHidden()
                    SetAlarmButton(viewModel: viewModel)
                    
                    if viewModel.isVisible {
                        AlarmSetText(viewModel: viewModel)
                    }
                    
                    List {
                        ForEach((1...20), id: \.self) {_ in
                            AlarmTableViewCell()
                                .listRowBackground(Color("secondaryBackgroundColor"))
                                
                        }
                    }
                    .shadow(color: .blue, radius: 10, x: 0, y: 10)

                    .background {
                        Image("bg")
                            .resizable()
                            .opacity(0.2)
                            .scaledToFit()
                            .frame(width: 200, height: 200, alignment: .center)
                    }
                    .scrollContentBackground(.hidden)
                    Spacer()
                }
                
            }
        }
        .navigationViewStyle(.stack)
        .task {
            viewModel.requestAuthorization()
            await viewModel.getCurrentSettings()
            await viewModel.getPendingRequests()
        }
        
    }
}


struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(viewModel: AlarmViewModel(lnManager: LocalNotificationsManager()))
    }
}
