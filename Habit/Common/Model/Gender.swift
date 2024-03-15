//
//  Gender.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 14/02/24.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male = "Male"
    case female = "Female"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex{ self == $0 } ?? 0
    }
}
