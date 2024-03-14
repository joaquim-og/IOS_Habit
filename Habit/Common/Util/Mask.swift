//
//  Mask.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 14/03/24.
//

import Foundation

class Mask {
    
    private static var isUpdating = false
    private static var oldString = ""
    
    enum MaskPattern: String {
        case brazilianCpf = "###.###.###-##"
        case phone = "(##) ####-####"
        case phoneWithExtraDigit = "(##) #####-####"
    }
    
    static func mask(
        mask: MaskPattern,
        value: String,
        text: inout String
    ) {
        let rawString = replaceChars(fullString: value)
        
        var _mask = mask.rawValue
        if (_mask == MaskPattern.phone.rawValue) {
            if (value.count >= 14 && value.characterAtindex(index: 5) == "9") {
                _mask = MaskPattern.phoneWithExtraDigit.rawValue
            }
        }
        
        var newValueWithMask = ""
        
        if (rawString <= oldString) {
            isUpdating = true
            if (_mask == MaskPattern.phoneWithExtraDigit.rawValue && value.count >= 14) {
                _mask = MaskPattern.phone.rawValue
            }
        }
        
        if (isUpdating || value.count == mask.rawValue.count) {
            oldString = rawString
            isUpdating = false
            return
        }
        
        var i = 0
        for char in _mask {
            if (char != "#" && rawString.count > oldString.count) {
                newValueWithMask = newValueWithMask + String(char)
                continue
            }
            
            let unamed = rawString.characterAtindex(index: i)
            guard let char = unamed else { break }
            
            newValueWithMask = newValueWithMask + String(char)
            
            i += 1
        }
        
        isUpdating = true
        
        if (newValueWithMask == "(0") {
            text = ""
            return
        }
        
        text = newValueWithMask
    }
    
    private static func replaceChars(fullString: String) -> String {
        return fullString
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
}
