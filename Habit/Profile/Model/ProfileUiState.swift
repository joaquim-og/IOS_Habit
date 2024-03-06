//
//  ProfileUiState.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 05/03/24.
//

import Foundation

enum ProfileUiState: Equatable {
    case loading
    case none
    case success
    case error(String)
}
