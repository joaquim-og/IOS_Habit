//
//  HabitSelectGenderView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 06/03/24.
//

import SwiftUI

struct HabitGenderSelectorView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var selectedGender: Gender?
    let title: String
    let genders: [Gender]

    var body: some View {
        
        let unselectedColor = if (colorScheme == .dark) {
            Color.black
        } else {
            Color.white
        }
        
        Form {
            Section(
                header: Text(title),
                content: {
                    List(genders, id: \.id) { actualGender in
                        HStack{
                            Text(actualGender.rawValue)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(
                                    selectedGender == actualGender ? Color.orange : unselectedColor
                                )
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if (selectedGender != actualGender) {
                                selectedGender = actualGender
                            }
                        }
                        
                    }
                }
            )
        }
    }
}

struct HabitSelectGenderView_Previews: PreviewProvider {
    static var previews: some View {
        let title = "Xablau"
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitGenderSelectorView(
                selectedGender: .constant(Gender.male),
                title: title,
                genders: Gender.allCases
            )
            .preferredColorScheme($0)
        }
    }
}
