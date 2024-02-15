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
}
