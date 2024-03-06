//
//  ProfileViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 05/03/24.
//

import Foundation
import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    
    @Published var uiState: ProfileUiState = .success
    @Published var userName = ""
    @Published var userEmail = "xablau@xablaueixonserver.com"
    @Published var userDocument = "123456798"
    @Published var userPhone = "987654321"
    @Published var userBirthday = Date()
    @Published var userGender: Gender? = nil

    
    private let interactor: ProfileInteractor
    private var profileCancellable: AnyCancellable?
    
    init(
        interactor: ProfileInteractor
    ){
        self.interactor = interactor
    }
    
    deinit {
        profileCancellable?.cancel()
    }
    
    func getUserProfileData() {
        setLoadingState()
        //        habitDetailCancellable = interactor.saveHabitValue(
        //            habitId: id,
        //            request: HabitDetailsValueRequest(value: value)
        //        )
        //        .receive(on: DispatchQueue.main)
        //        .sink { onComplete in
        //            switch (onComplete) {
        //            case .failure(let appError):
        //                self.setErrorState(errorMessage: appError.message)
        //                break
        //            case .finished:
        //                break
        //            }
        //        } receiveValue: { successResponse in
        //            if (successResponse) {
        //                self.setSuccessState()
        //            } else {
        //                self.setErrorState(errorMessage: "Não foi possível salvar agora, tente novamente mais tarde")
        //                self.sendPublishserState(state: false)
        //            }
        //        }
    }
    
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setSuccessState() {
        DispatchQueue.main.async {
            self.uiState = .success
        }
    }
    
    private func setErrorState(errorMessage: String) {
        DispatchQueue.main.async {
            self.uiState = .error(errorMessage)
        }
    }
    
}
