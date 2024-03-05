//
//  HabitCardViewRouter.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 05/03/24.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter {
    
    static func makeHabitDetailView(
        interactor: HabitDetailInteractor = HabitDetailInteractor(),
        id: Int,
        name: String,
        label: String,
        habitPublisher: PassthroughSubject<Bool, Never>?
    ) -> some View {
        let viewModel = HabitDetailsViewModel(
            interactor: interactor,
            id: id,
            name: name,
            label: label
        )
        viewModel.habitPublisher = habitPublisher
        return HabitDetailView(viewModel: viewModel)
    }
    
}
