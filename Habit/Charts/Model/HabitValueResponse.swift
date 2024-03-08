//
//  HabitValueResponse.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 08/03/24.
//

import Foundation

struct HabitValueResponse: Decodable {
    
    let id: Int
    let value: Int
    let habitId: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case habitId = "habit_id"
        case createdDate = "created_date"
    }
}
