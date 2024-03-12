//
//  HabitView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUiState.loading = viewModel.uiState {
                progress
            } else {
                NavigationView {
                    ScrollView(
                        showsIndicators: false,
                        content: {
                            VStack(spacing: 12) {
                                
                                if (!viewModel.isCharts){
                                    topContainer
                                    addButton
                                }
                                
                                if case HabitUiState.emptyList = viewModel.uiState {
                                    Spacer(minLength: 60)
                                    emptyListView
                                } else if case HabitUiState.fullList(let rows) = viewModel.uiState {
                                    
                                    LazyVStack {
                                        ForEach(rows) { row in
                                            HabitCardView.init(
                                                isChart: viewModel.isCharts,
                                                viewModel: row
                                            )
                                        }
                                    }.padding(.horizontal, 14)
                                    
                                } else if case HabitUiState.error(let msg) = viewModel.uiState {
                                    Text("")
                                        .alert(
                                            isPresented: .constant(true),
                                            content: {
                                                Alert(
                                                    title: Text("Ops \(msg)"),
                                                    message: Text("Tentar novamente?"),
                                                    primaryButton: .default(Text("Sim")) {
                                                        viewModel.onAppear()
                                                    },
                                                    secondaryButton: .cancel()
                                                )
                                            }
                                        )
                                }
                            }
                        }
                    )
                }
            }
        }.onAppear {
            if (!viewModel.opened) {
                viewModel.onAppear()
            }
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(
            alignment: .center,
            spacing: 12,
            content: {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                
                Text(viewModel.title)
                    .font(Font.system(.title).bold())
                    .foregroundColor(Color.orange)
                
                Text(viewModel.headline)
                    .font(Font.system(.title3).bold())
                    .foregroundColor(Color("editTextColor"))
                
                Text(viewModel.description)
                    .font(Font.system(.subheadline))
                    .foregroundColor(Color("editTextColor"))
            }
        )
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .navigationTitle("Meus Hábitos")
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink(
            destination:
                viewModel.habitCreateView()
                .frame(maxWidth: .infinity, maxHeight: .infinity),
            label: {
                Label("Criar Hábito", systemImage: "plus.app")
                    .modifier(ButtonStyle())
            }
        )
        .padding(.horizontal, 16)
    }
}

extension HabitView {
    var emptyListView: some View {
        VStack{
            Image(systemName: "exclamationmark.octagon.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24, alignment: .center)
            
            Text("Nenhum Hábito encontrado 🫨")
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HabitViewModel(isCharts: false, interactor: HabitInteractor())
        
        HabitView(viewModel: viewModel)
    }
}
