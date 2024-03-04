//
//  HabitDetailUiState.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 04/03/24.
//

import Foundation

enum HabitDetailUiState: Equatable {
    case loading
    case none
    case success
    case error(String)
}
