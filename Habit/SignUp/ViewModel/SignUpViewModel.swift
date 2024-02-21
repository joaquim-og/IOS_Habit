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
        
        let request = SignUpRequest(
            fullName: fullName,
            email: email,
            password: password,
            document: document,
            phone:phone,
            birthday: birthday.formatToPattern(pattern: Date.DatesPatterns.YYYYMMDD),
            gender: gender.index
        )
        
        WebService.postUser(
            request: request,
            onComplete: {(successResponse, errorResponse) in
                if let error = errorResponse {
                    self.setErrorState(error: error.detail)
                }
                if let success = successResponse {
                    if (success){
                        WebService.login(
                            request: SignInRequest(
                                email: self.email,
                                password: self.password
                            ),
                            onComplete: {(successResponse, errorResponse) in
                                if let error = errorResponse {
                                    self.setErrorState(error: error.detail?.message ?? "")
                                }
                                if let success = successResponse {
                                    self.setSuccessState()
                                }
                            })
                    } else {
                        self.setErrorState(error: "We have some problems. Please try again later.")
                    }
                }
            })
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setSuccessState() {
        DispatchQueue.main.async {
            self.uiState = .success
            self.signUpPublisher.send(true)
        }
    }
    
    private func setErrorState(error: String) {
        DispatchQueue.main.async {
            self.uiState = .error(error)
        }
    }
    
}
