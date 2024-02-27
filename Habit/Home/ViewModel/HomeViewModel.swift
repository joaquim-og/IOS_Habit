//
//  HomeViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    
    @Published var uiState: HomeUiState = .none
    
    
    
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView()
    }
}
