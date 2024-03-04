//
//  HomeViewRouter.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
    
}
