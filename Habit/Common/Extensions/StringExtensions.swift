//
//  StringExtensions.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 15/02/24.
//

import Foundation

extension String {
    func isEmail() -> Bool{
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func isTextValidLenght(minLenght: Int) -> Bool {
        return self.count >= minLenght
    }
    
    func formatStringToPattern(sourcePattern: Date.DatesPatterns, destPattern: Date.DatesPatterns) -> String? {
        let dateFormatter = getDateFormatter(pattern: sourcePattern)
        
        let dateFormatted = dateFormatter.date(from: self)
        
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        dateFormatter.dateFormat = destPattern.rawValue
        return dateFormatter.string(from: dateFormatted)
    }
    
    func formatStringToDate(sourcePattern: Date.DatesPatterns) -> Date? {
        let dateFormatter = getDateFormatter(pattern: sourcePattern)
        
        return dateFormatter.date(from: self)
    }
    
}
