//
//  ChartsUiState.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 07/03/24.
//

import Foundation

enum ChartsUiState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
