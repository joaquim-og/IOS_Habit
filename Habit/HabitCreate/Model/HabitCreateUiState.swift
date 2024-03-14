//
//  HabitCreateUiState.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 12/03/24.
//

import Foundation

enum HabitsCreateUiState: Equatable {
    case loading
    case none
    case success
    case error(String)
}
