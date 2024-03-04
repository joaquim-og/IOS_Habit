//
//  HabitDetailView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 04/03/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailsViewModel
    
    init(viewModel: HabitDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(
            showsIndicators: false,
            content: {
                VStack(
                    alignment: .center,
                    spacing: 12,
                    content: {
                        Text(viewModel.name)
                            .foregroundColor(Color.orange)
                        font(.title.bold())
                        
                        Text("Unidade: \(viewModel.name)")
                    }
                )
                
                VStack(
                    alignment: .center,
                    spacing: 12,
                    content: {
                        TextField(
                            "Jot here the value conquered",
                            text: $viewModel.value
                            )
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.numberPad)
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray)
                    }
                ).padding(.horizontal,32)
                
                Text("Os registros devem ser feitos em até 24 horas. \n Habitos se controes todos os dias :)")
                                
                savebutton
                
                Button("Cancelar") {
                    
                }
                .modifier(ButtonStyle())
                .padding(.horizontal,8)
                
                Spacer()
            }
        ).padding(.horizontal, 8)
            .padding(.top, 32)
    }
}

extension HabitDetailView {
    var savebutton: some View {
        HabitLoadingButtonView(
            buttonText: "Salvar",
            action: {
               // viewModel.signUp()
            },
            disabled: self.viewModel.value.isEmpty,
            showProgressBar: self.viewModel.uiState == .loading
        ).padding(.horizontal, 16)
            .padding(.vertical, 8)
    }
}



struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            let viewModel = HabitDetailsViewModel(
                interactor: HabitDetailInteractor(),
                id: 0,
                name: "NAme Xablau",
                label: "Label Xablau"
            )
            
            HabitDetailView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme(colorScheme)
        }
    }
}
