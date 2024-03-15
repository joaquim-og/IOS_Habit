//
//  HabitViewRouter.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 12/03/24.
//

import Foundation

import SwiftUI
import Combine

enum HabitViewRouter {
    
    static func makeHabitCreateView(
        habitCreatePublisher: PassthroughSubject<Bool, Never>?
    ) -> some View {
        let viewModel = HabitCreateViewModel(
            interactor: HabitsCreateInteractor()
        )
        viewModel.habitCreatePublisher = habitCreatePublisher
        return HabitCreateView(viewModel: viewModel)
    }
    
}
