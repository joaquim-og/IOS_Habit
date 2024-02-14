//
//  SignUpViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    var signUpPublisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUiState = .none
    
    func signUp() {
        
        setLoadingState()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.signUpPublisher.send(true)
        }
    }
    
    private func setLoadingState() {
        self.uiState = .loading
    }

    
    private func setErrorState(error: String) {
        self.uiState = .error(error)
    }
        
}
