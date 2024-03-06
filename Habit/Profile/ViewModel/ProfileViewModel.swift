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
    
    
    @Published var uiState: ProfileUiState = .loading
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userDocument = ""
    @Published var userPhone = ""
    @Published var userBirthday = Date()
    @Published var userGender: Gender?
    
    private var userId: Int?
    
    private let interactor: ProfileInteractor
    private var getUserCancellable: AnyCancellable?
    private var updateUserCancellable: AnyCancellable?
    
    init(
        interactor: ProfileInteractor
    ){
        self.interactor = interactor
    }
    
    deinit {
        getUserCancellable?.cancel()
        updateUserCancellable?.cancel()
    }
    
    func getUserProfileData() {
        setLoadingState()
        getUserCancellable = interactor.fetchUser()
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
                self.mapUserData(successResponse: successResponse)
                self.setSuccessState()
            }
    }
    
    func updateUserProfileData() {
        setUpdateState(state: .updateLoading)
        
        guard let userIdToRequest = userId,
              let genderToRequest = userGender 
        else {
            self.setUpdateErrorState(errorMessage: "Something went wrong :(")
            return
        }
        
        let request = ProfileRequest(
            fullName: userName,
            phone: userPhone,
            birthday: userBirthday.formatDateToString(pattern: Date.DatesPatterns.YYYYMMDD),
            gender: genderToRequest.index
        )
        
        updateUserCancellable = interactor.updateUser(userId: userIdToRequest, request: request)
            .receive(on: DispatchQueue.main)
            .sink { onComplete in
                switch (onComplete) {
                case .failure(let appError):
                    self.setUpdateErrorState(errorMessage: appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { successResponse in
                self.mapUserData(successResponse: successResponse)
                self.setUpdateState(state: .updateSuccess)
            }
    }
    
    private func mapUserData(successResponse: ProfileResponse) {
        userId = successResponse.id
        userName = successResponse.fullName
        userEmail = successResponse.email
        userDocument = successResponse.document
        userPhone = successResponse.phone
        userBirthday = successResponse.birthday.formatStringToDate(sourcePattern: Date.DatesPatterns.YYYYMMDD) ?? Date()
        userGender = Gender.allCases[successResponse.gender]
        
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
    
    func setUpdateState(state: ProfileUiState) {
        DispatchQueue.main.async {
            self.uiState = state
        }
    }
    
    private func setUpdateErrorState(errorMessage: String) {
        DispatchQueue.main.async {
            self.uiState = .updateError(errorMessage)
        }
    }
    
    private func setErrorState(errorMessage: String) {
        DispatchQueue.main.async {
            self.uiState = .error(errorMessage)
        }
    }
    
}
