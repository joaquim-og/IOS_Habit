//
//  HabitDetailView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 04/03/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.orange)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                
                Text("Unidade: \(viewModel.label)")
            }
            
            VStack {
                TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            Text("Os registros devem ser feitos em até 24h.\nHábitos se constroem todos os dias :)")
            
            HabitLoadingButtonView(
                action: {
                    viewModel.saveHabitValue()
                },
                buttonText: "Salvar",
                showProgress: self.viewModel.uiState == .loading,
                disabled: self.viewModel.value.isEmpty)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button("Cancelar") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitDetailView(
                viewModel: HabitDetailsViewModel(
                    interactor: HabitDetailInteractor(),
                    id: 1,
                    name: "Xablauin",
                    label: "xablau horas")
            )
            .preferredColorScheme($0)
        }
    }
}
