//
//  HomeViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
   let viewModel = HabitViewModel(interactor: HabitInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
}
