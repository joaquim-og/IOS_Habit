//
//  DateExtensions.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 16/02/24.
//

import Foundation

extension Date {
    
    enum DatesPatterns: String {
        case DDMM = "dd/MM"
        case DDMMYYYY = "dd-MM-yyyy"
        case DDMMYYYYHHMM = "dd/MM/yyyy HH:mm"
        case YYYYMMDD = "yyyy-MM-dd"
        case YYYYMMDDHHMM = "yyyy-MM-dd HH:mm"
        case YYYYMMDDTHHMMSS = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    enum LocalIdentifier: String {
        case ENUSPOSIX = "en_us_POSIX"
    }
    
    func formatDateToString(pattern: DatesPatterns) -> String {
        let dateFormatter = getDateFormatter(pattern: pattern)
        
        return dateFormatter.string(from: self)
    }
        
}

func getDateFormatter(pattern: Date.DatesPatterns) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: Date.LocalIdentifier.ENUSPOSIX.rawValue)
    dateFormatter.dateFormat = pattern.rawValue
    
    return dateFormatter
}
