//
//  Gender.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 14/02/24.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    
    var id: String {
        self.rawValue
    }
}
