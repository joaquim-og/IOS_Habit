//
//  DateExtensions.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 16/02/24.
//

import Foundation

extension Date {
    
    enum DatesPatterns: String {
        case DDMMYYYYPattern = "dd-MM-yyyy"
        case YYYYMMDD = "yyyy-MM-dd"
    }
    
    func formatToPattern(pattern: DatesPatterns) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern.rawValue
        
        return dateFormatter.string(from: self)
    }
    
}
