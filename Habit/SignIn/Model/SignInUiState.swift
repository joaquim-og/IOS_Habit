//
//  SignInUiState.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import Foundation

enum SignInUiState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
