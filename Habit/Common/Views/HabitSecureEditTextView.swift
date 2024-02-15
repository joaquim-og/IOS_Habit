//
//  EditTextView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 15/02/24.
//

import SwiftUI

struct HabitSecureEditTextView: View {
    
    @Binding var text: String
    
    var placeHolder: String = ""
    var error: String? = nil
    var failure: Bool? = nil
    var borderColor: Color = Color.orange
    
    var body: some View {
        VStack{
            SecureField(
                placeHolder,
                text: $text
            )
            .textFieldStyle(CustomTextFieldStyle())
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(borderColor, lineWidth: 0.8)
            )
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
    }
}

struct HabitSecureEditTextViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            VStack {
                HabitSecureEditTextView(
                    text: .constant("XABLAUEIXON"),
                    placeHolder: "Xablau placeholder",
                    error: "Xablau error",
                    failure: "2@2.com".count < 5
                ).padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}
