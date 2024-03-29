//
//  HabitCardView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import SwiftUI

struct HabitCardView: View {
    
    @State private var action = false
    
    let isChart: Bool
    let viewModel: HabitCardViewModel
    
    var body: some View {
        ZStack(
            alignment: .trailing,
            content: {
                
                if (isChart){
                    NavigationLink(
                        destination: viewModel.chartView(),
                        isActive: self.$action,
                        label: {
                            EmptyView()
                        }
                    )
                } else {
                    NavigationLink(
                        destination: viewModel.habitDetailView(),
                        isActive: self.$action,
                        label: {
                            EmptyView()
                        }
                    )
                }
                
                Button (
                    action: {
                        self.action = true
                    },
                    label: {
                        HStack{
                            if (viewModel.icon.isEmpty) {
                                Image(systemName: "pencil")
                                    .padding(.horizontal, 8)
                            } else {
                                HabitImageView(url: viewModel.icon)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                    .clipped()
                            }
                            
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
                                            Text("Registered")
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
                
                if (!isChart) {
                    Rectangle()
                        .frame(width: 8)
                        .foregroundColor(viewModel.state)
                }
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
                    HabitCardView(isChart: false, viewModel: model)
                    HabitCardView(isChart: true, viewModel: model)
                }
                .frame(maxWidth: .infinity)
                .navigationTitle("TEste")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}
