//
//  SplashViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 26/04/23.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUistate = .loading

    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.uiState = .goToSignScreen
        }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
