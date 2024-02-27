//
//  HabitUiState.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import Foundation

enum HabitUiState: Equatable {
    case loading
    case emptyList
    case fullList
    case error(String)
}
