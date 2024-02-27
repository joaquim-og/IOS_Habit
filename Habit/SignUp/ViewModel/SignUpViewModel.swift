//
//  SignUpViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    
    
    @Published var uiState: SignUpUiState = .none
    
    func login(email: String, password: String){
        
        setLoadingState()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           
        }
    }
    
    private func setLoadingState() {
        self.uiState = .loading
    }

    
    private func setErrorState(error: String) {
        self.uiState = .error(error)
    }
        
}
