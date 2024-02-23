//
//  SplashViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 26/04/23.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    
    private let interactor: SplashInteractor
    private var splashCancellable: AnyCancellable?

    @Published var uiState: SplashUistate = .loading

    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        splashCancellable?.cancel()
    }
    
    func onAppear() {
        splashCancellable = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if (userAuth == nil) {
                    self.updateSplashUiState(state: .goToSignScreen)
                } else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    // todo
                    // call refresh token in api
                } else {
                    self.updateSplashUiState(state: .goToHomeScreen)
                }
            }
    }
    
    func updateSplashUiState(state: SplashUistate) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.uiState = state
        }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
