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
    private var requestSignUpCancellable: AnyCancellable?
    private var requestSignInCancellable: AnyCancellable?
    private let signUpInteractor: SignUpInteractor
    
    
    @Published var uiState: SignUpUiState = .none
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = Date()
    @Published var gender = Gender.male
    
    init(signUpInteractor: SignUpInteractor) {
        self.signUpInteractor = signUpInteractor
    }
    
    deinit {
        requestSignUpCancellable?.cancel()
        requestSignInCancellable?.cancel()
    }
    
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
        
        requestSignUpCancellable = signUpInteractor.signUp(
            request: request
        )
        .receive(on: DispatchQueue.main)
        .sink { onComplete in
            switch (onComplete) {
            case .failure(let appError):
                self.setErrorState(error: appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { successSignUp in
            if (successSignUp) {
                self.requestSignInCancellable = self.signUpInteractor.login(
                    request: SignInRequest(
                        email: self.email,
                        password: self.password
                    )
                )
                .receive(on: DispatchQueue.main)
                .sink { onComplete in
                    switch (onComplete) {
                    case .failure(let appError):
                        self.setErrorState(error: appError.message)
                        break
                    case .finished:
                        break
                    }
                } receiveValue: { successResponse in
                    self.setSuccessState()
                }
            } else {
                self.setErrorState(error: "User created, but can't login by now. Please try again later.")
            }
        }
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
