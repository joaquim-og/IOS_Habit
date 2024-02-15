//
//  AlertComponent.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 14/02/24.
//

import SwiftUI

struct HabitErrorAlert: View {
    let error: String
    
    var body: some View {
        Text("").alert(isPresented: .constant(true)) {
            Alert(title: Text("Habit"),
                  message: Text(error),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct HabitErrorAlertPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            HabitErrorAlert(error: "XAblau o erro")
                .preferredColorScheme(colorScheme)
        }
    }
}
