//
//  AlertComponent.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 14/02/24.
//

import SwiftUI

struct HabitErrorAlertComponent: View {
    let error: String
    
    var body: some View {
        Text("").alert(isPresented: .constant(true)) {
            Alert(title: Text("Habit"),
                  message: Text(error),
                  dismissButton: .default(Text("OK")))
        }
    }
}
