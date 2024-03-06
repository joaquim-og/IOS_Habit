//
//  IntExtensions.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 06/03/24.
//

import Foundation

extension Int {
    
    func mapIntToGenderEnum() -> Gender {
        return if (self == 0) {
            Gender.male
        } else {
            Gender.female
        }
    }
    
}
