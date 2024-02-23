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
    private var refreshTokenCancellable: AnyCancellable?
    
    @Published var uiState: SplashUistate = .loading
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        splashCancellable?.cancel()
        refreshTokenCancellable?.cancel()
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
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.refreshTokenCancellable = self.interactor.refreshToken(request: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { onComplete in
                            switch (onComplete) {
                            case .failure(_):
                                self.updateSplashUiState(state: .goToSignScreen)
                                break
                            default:
                                break
                            }
                        }, receiveValue: { successResponse in
                            self.interactor.insertAuth(
                                userAuth: UserAuth(
                                    idToken: successResponse.accessToken,
                                    refreshToken: successResponse.refreshToken,
                                    expires: Date().timeIntervalSince1970 + Double(successResponse.expires),
                                    tokenType: successResponse.tokenType
                                )
                            )
                            self.updateSplashUiState(state: .goToHomeScreen)
                        })
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
