//
//  ContentView.swift
//  task2_app
//
//  Created by Ahmet Ali ÇETİN on 30.08.2023.
//

import SwiftUI

struct AlarmView: View {
    @StateObject private var viewModel: AlarmViewModel
    @State private var alarms = [Date]()
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
                    SetAlarmButton(viewModel: viewModel, alarms: $alarms)
                    
                    if viewModel.isVisible {
                        AlarmSetText(viewModel: viewModel)
                    }
                    
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
                        
                        List {
                            ForEach(alarms, id: \.self) { alarm in
                                AlarmTableViewCell(alarmDate: alarm)
                                    .listRowBackground(Color("secondaryBackgroundColor"))
                            }
                            .onDelete(perform: deleteItem)
                        }
                        .transition(.opacity)
                        
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
    func deleteItem(at offsets: IndexSet) {
        withAnimation {
            alarms.remove(atOffsets: offsets)
        }
    }
}


struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(viewModel: AlarmViewModel(lnManager: LocalNotificationsManager(), alarms: .constant([.distantFuture])))
    }
}
