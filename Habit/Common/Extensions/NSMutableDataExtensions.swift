//
//  NSMutableDataExtensions.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 14/03/24.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String ) {
        append(string.data(using: .utf8, allowLossyConversion: true)!)
    }
}
