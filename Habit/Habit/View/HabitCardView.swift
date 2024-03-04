//
//  HabitCardView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import SwiftUI

struct HabitCardView: View {
    
    @State private var action = false
    
    let viewModel: HabitCardViewModel
    
    var body: some View {
        ZStack(
            alignment: .trailing,
            content: {
                NavigationLink(
                    destination: HabitDetailView(
                        viewModel: HabitDetailsViewModel(
                            interactor: HabitDetailInteractor(),
                            id: viewModel.id,
                            name: viewModel.name,
                            label: viewModel.label
                        )
                    ),
                    isActive: self.$action,
                    label: {
                        EmptyView()
                    }
                )
                
                Button (
                    action: {
                        self.action = true
                    },
                    label: {
                        HStack{
                            Image(systemName: "pencil")
                                .padding(.horizontal, 8)
                            
                            Spacer()
                            
                            HStack(
                                alignment: .top,
                                content: {
                                    
                                    Spacer()
                                    
                                    VStack(
                                        alignment: .leading, 
                                        spacing: 4,
                                        content: {
                                            Text(viewModel.name)
                                                .foregroundColor(Color.orange)
                                            
                                            Text(viewModel.label)
                                                .foregroundColor(Color("editTextColor"))
                                                .bold()          
                                            
                                            Text(viewModel.date)
                                                .foregroundColor(Color("editTextColor"))
                                                .bold()
                                        }
                                    ).frame(maxWidth: 300, alignment: .leading)
                                    
                                    Spacer()
                                    
                                    VStack(
                                        alignment: .leading,
                                        spacing: 4,
                                        content: {
                                            Text("Registrado")
                                                .foregroundColor(Color.orange)
                                                .bold()
                                                .multilineTextAlignment(.leading)
                                            
                                            Text(viewModel.value)
                                                .foregroundColor(Color("editTextColor"))
                                                .bold()
                                                .multilineTextAlignment(.leading)
                                        }
                                    )
                                    Spacer()
                                }
                            )
                            Spacer()
                        }
                        .padding()
                        .cornerRadius(4.0)
                    }
                )
                
                Rectangle()
                    .frame(width: 8)
                    .foregroundColor(viewModel.state)
                
            }
        ).background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.orange, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x:2, y:2)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            
            let model = HabitCardViewModel(
                id: 1,
                icon: "https://placehold.co/150x150",
                date: "01/01/2024 00:00:00",
                name: "Xablauizar",
                label: "Horas",
                value: "2",
                state: Color.green
            )
            
            NavigationView {
                List {
                    HabitCardView(viewModel: model)
                    HabitCardView(viewModel: model)
                }
                .frame(maxWidth: .infinity)
                .navigationTitle("TEste")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}
