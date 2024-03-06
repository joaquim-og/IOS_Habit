//
//  HomeViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
   let habitViewModel = HabitViewModel(interactor: HabitInteractor())
   let profileViewModel = ProfileViewModel(interactor: ProfileInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }    
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}
