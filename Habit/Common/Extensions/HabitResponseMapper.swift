//
//  HabitResponseMapper.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 04/03/24.
//

import Foundation
import SwiftUI

extension HabitResponse {
    
    func mapResponseToDomain(stateColor: Color) -> HabitCardViewModel {
        return HabitCardViewModel(
            id: Int(self.id) ?? 0,
            icon: self.iconUrl ?? "",
            date: self.lastDate?.formatStringToPattern(
                sourcePattern: Date.DatesPatterns.YYYYMMDDTHHMMSS,
                destPattern: Date.DatesPatterns.YYYYMMDD
            ) ?? "",
            name: self.name,
            label: self.label,
            value: String(self.value ?? 0),
            state: stateColor
        )
    }
    
}
