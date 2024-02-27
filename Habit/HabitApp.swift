//
//  HabitApp.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 22/03/23.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
