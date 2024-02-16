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
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = Date()
    @Published var gender = Gender.male
    
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
