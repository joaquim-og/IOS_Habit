//
//  ChartsView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 07/03/24.
//

import SwiftUI

struct ChartsView: View {
    
    @State var habitId: Int
    
    var body: some View {
        Text("XAblau aqui o habitId -> \(habitId)")
    }
}

struct PChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ChartsView(habitId: 1)
            .preferredColorScheme($0)
        }
    }
}
