//
//  SiginViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 09/10/23.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    private var signInCancellable: AnyCancellable?
    private var requestCancellable: AnyCancellable?
    private let signInPublisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    private let homeViewModel: HomeViewModel
    
    @Published var uiState: SignInUiState = .none
    @Published var email = ""
    @Published var password = ""
    
    init(
        interactor: SignInInteractor,
        homeViewModel: HomeViewModel
    ) {
        self.interactor = interactor
        self.homeViewModel = homeViewModel
        
        signInCancellable = signInPublisher.sink { isRegisterSuccessful in
            if (isRegisterSuccessful) {
                self.setHomeNavigationState()
            }
        }
    }
    
    func login() {
        
        setLoadingState()
        
        let request = SignInRequest(
            email: email,
            password: password
        )
        
        requestCancellable = interactor.login(
            request: request
        )
        .receive(on: DispatchQueue.main)
        .sink { onComplete in
            switch (onComplete) {
            case .failure(let appError):
                self.setErrorState(errorMessage: appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { successResponse in
            self.interactor.insertAuth(
                userAuth: UserAuth(
                    idToken: successResponse.accessToken,
                    refreshToken: successResponse.refreshToken,
                    expires: Date().timeIntervalSince1970 + Double(successResponse.expires),
                    tokenType: successResponse.tokenType
                )
            )
            self.setHomeNavigationState()
        }
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setErrorState(errorMessage: String) {
        self.uiState = .error(errorMessage)
    }
    
    private func setHomeNavigationState() {
        self.uiState = .goToHomeScreen
    }
    
    deinit {
        signInCancellable?.cancel()
        requestCancellable?.cancel()
    }
    
}

// MARK: - Navigation Routers
extension SignInViewModel {
    func navigateToHomeView() -> some View {
        return SignInViewRouter.navigateToHomeViewFromSignIn(homeViewModel: homeViewModel)
    }
    
    func navigateToSignUpView() -> some View {
        return SignInViewRouter.navigateToSignUpView(publisher: signInPublisher)
    }
}
