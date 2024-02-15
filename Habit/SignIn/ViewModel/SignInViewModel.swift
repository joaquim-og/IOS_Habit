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
    
    init() {
        signInCancellable = signInPublisher.sink { isRegisterSuccessful in
            if (isRegisterSuccessful) {
                self.setHomeNavigationState()
            }
        }
    }
    
    func login(email: String, password: String){
        
        setLoadingState()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setHomeNavigationState()
        }
    }
    
    private func setLoadingState() {
        self.uiState = .loading
    }
    
    private func setErrorState(errorMessage: String) {
        self.uiState = .error(errorMessage)
    }
    
    private func setHomeNavigationState() {
        self.uiState = .goToHomeScreen
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
