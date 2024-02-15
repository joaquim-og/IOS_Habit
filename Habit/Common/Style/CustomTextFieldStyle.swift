//
//  CustomTextFieldStyle.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 15/02/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .foregroundColor(Color("editTextColor"))
    }
    
    
}
