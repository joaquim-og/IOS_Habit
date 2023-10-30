//
//  SiginViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 09/10/23.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    
    @Published var uiState: SignInUiState = .none
    
    func login(email: String, password: String){
        
        setLoadingState()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setHomeNavigationState()
        }
    }
    
    private func setLoadingState() {
        self.uiState = .loading
    }
    
    
    private func setHomeNavigationState() {
        self.uiState = .goToHomeScreen
    }
        
}

// MARK: - Navigation Routers
extension SignInViewModel {
    func navigateToHomeView() -> some View {
        return SignInViewRouter.navigateToHomeView()
    }
    
    func navigateToSignUpView() -> some View {
        return SignInViewRouter.navigateToSignUpView()
    }
}
