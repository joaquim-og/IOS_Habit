//
//  HabitCardViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import Foundation
import SwiftUI

struct HabitCardViewModel: Identifiable, Equatable {
    
    var id: Int = 0
    var icon: String = ""
    var date: String = ""
    var name: String = ""
    var label: String = ""
    var value: String = ""
    var state: Color = .green
    
    static func == (lhs: HabitCardViewModel, rhs: HabitCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
        
}

extension HabitCardViewModel {
    func habitDetailView() -> some View {
        return HabitCardViewRouter.makeHabitDetailView(
            id: id,
            name: name,
            label: label
        )
    }
}
