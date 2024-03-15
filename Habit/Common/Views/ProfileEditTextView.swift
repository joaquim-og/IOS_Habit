//
//  ProfileEditTextView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 14/03/24.
//

import SwiftUI

struct ProfileEditTextView: View {
    
    @Binding var text: String
    
    var placeHolder: String = ""
    var mask: Mask.MaskPattern? = nil
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
            .multilineTextAlignment(.trailing)
        }
        .padding(.bottom, 10)
    }
}

struct ProfileEditTextViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            VStack {
                ProfileEditTextView(
                    text: .constant("XABLAUEIXON"),
                    placeHolder: "Xablau placeholder"
                ).padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}
