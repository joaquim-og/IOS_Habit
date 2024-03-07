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
        VStack {
            BoxChartView(
                chartEntries: $viewModel.entries,
                dates: $viewModel.dates
            )
            .frame(maxWidth: .infinity, maxHeight: 350)
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
