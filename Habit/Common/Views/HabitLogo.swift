//
//  HabitLogo.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI

struct HabitLogo: View {
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 48)
    }
}

struct HabitLogoSplash: View {
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(20)
            .ignoresSafeArea()
    }
}


struct HabitLogoPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            HabitLogo()
                .preferredColorScheme(colorScheme)
        }
    }
}


struct HabitLogoSplashPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            HabitLogoSplash()
                .preferredColorScheme(colorScheme)
        }
    }
}
