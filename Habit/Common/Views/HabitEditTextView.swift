//
//  EditTextView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 14/02/24.
//

import SwiftUI

struct HabitEditTextView: View {
    
    @Binding var text: String
    
    var placeHolder: String = ""
    var mask: Mask.MaskPattern? = nil
    var error: String? = nil
    var failure: Bool? = nil
    var borderColor: Color = Color.orange
    var keyboard: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack{
            TextField(
                placeHolder,
                text: $text
            )
            .keyboardType(keyboard)
            .textFieldStyle(CustomTextFieldStyle())
            .onChange(of: text) { value in
                if let mask = mask {
                    Mask.mask(mask: mask, value: value, text: &text)
                }
            }
            .autocapitalization(autocapitalization)
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

struct HabitEditTextViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            VStack {
                HabitEditTextView(
                    text: .constant("XABLAUEIXON"),
                    placeHolder: "Xablau placeholder",
                    error: "Xablau error",
                    failure: "2@2.com".count < 3
                ).padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}
