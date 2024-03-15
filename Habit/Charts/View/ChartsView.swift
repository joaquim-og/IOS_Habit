//
//  ChartsView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 07/03/24.
//

import SwiftUI

struct ChartsView: View {
    
    @ObservedObject var viewModel: ChartsViewModel
    
    var body: some View {
        ZStack {
            
            if case ChartsUiState.loading = viewModel.uiState {
                progressView
            } else {
                VStack {
                    if case ChartsUiState.emptyChart = viewModel.uiState {
                        emptyListView
                    } else if case ChartsUiState.error(let msg) = viewModel.uiState {
                        Text("")
                            .alert(
                                isPresented: .constant(true),
                                content: {
                                    Alert(
                                        title: Text("Ops \(msg)"),
                                        message: Text("Try again?"),
                                        primaryButton: .default(Text("Yes")) {
                                            viewModel.onAppear()
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                            )
                    } else {
                        BoxChartView(
                            chartEntries: $viewModel.entries,
                            dates: $viewModel.dates
                        )
                        .frame(maxWidth: .infinity, maxHeight: 350)
                    }
                }
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

extension ChartsView {
    var progressView: some View {
        ProgressView()
    }
}

extension ChartsView {
    var emptyListView: some View {
        VStack{
            Image(systemName: "exclamationmark.octagon.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24, alignment: .center)
            
            Text("You don't have any Habits 🫨")
        }
    }
}

struct PChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ChartsView(
                viewModel: ChartsViewModel(interactor: ChartsInteractor(), habitId: 1)
            )
            .preferredColorScheme($0)
        }
    }
}
