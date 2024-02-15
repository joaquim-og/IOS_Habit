//
//  SignUpViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import Foundation

enum SignUpUiState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
