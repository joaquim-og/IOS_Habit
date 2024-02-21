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
    private let signInPublisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUiState = .none
    @Published var email = ""
    @Published var password = ""
    
    init() {
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
        
        WebService.login(
            request: request,
            onComplete: {(successResponse, errorResponse) in
                if let error = errorResponse {
                    debugPrint("Xablau aqui o error -> \(error.detail?.message ?? "")")
                    self.setErrorState(errorMessage: error.detail?.message ?? "")
                }
                if let success = successResponse {
                    debugPrint("Xablau aqui o success -> \(success)")
                    self.setHomeNavigationState()
                }
            })
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setErrorState(errorMessage: String) {
        DispatchQueue.main.async {
            self.uiState = .error(errorMessage)
        }
    }
    
    private func setHomeNavigationState() {
        DispatchQueue.main.async {
            self.uiState = .goToHomeScreen
        }
    }
    
    deinit {
        signInCancellable?.cancel()
    }
    
}

// MARK: - Navigation Routers
extension SignInViewModel {
    func navigateToHomeView() -> some View {
        return SignInViewRouter.navigateToHomeViewFromSignIn()
    }
    
    func navigateToSignUpView() -> some View {
        return SignInViewRouter.navigateToSignUpView(publisher: signInPublisher)
    }
}
