//
//  HabitViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import Foundation

class HabitViewModel: ObservableObject {
    
    
    @Published var uiState: HabitUiState = .emptyList
    
    @Published var title: String = "Atenção"
    @Published var headline: String = "Fique Ligado"
    @Published var description: String = "Você está atrasado nos hábitos"
    
    
    
}
