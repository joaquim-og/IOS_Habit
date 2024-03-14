//
//  HabitDetailsViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 04/03/24.
//

import Foundation
import Combine
import SwiftUI

class HabitDetailsViewModel: ObservableObject {
    
    
    @Published var uiState: HabitDetailUiState = .success
    @Published var value = ""
    
    let id: Int
    let name: String
    let label: String
    
    private let interactor: HabitDetailInteractor
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    private var habitDetailCancellable: AnyCancellable?
    
    init(
        interactor: HabitDetailInteractor,
        id: Int,
        name: String,
        label: String
    ){
        self.interactor = interactor
        self.id = id
        self.name = name
        self.label = label
    }
    
    deinit {
        habitDetailCancellable?.cancel()
    }
        
    func saveHabitValue() {
        setLoadingState()
        habitDetailCancellable = interactor.saveHabitValue(
            habitId: id,
            request: HabitDetailsValueRequest(value: value)
        )
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
            if (successResponse) {
                self.setSuccessState()
                self.sendPublishserState(state: true)
            } else {
                self.setErrorState(errorMessage: "Could not save now, please try again later.")
                self.sendPublishserState(state: false)
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
        }
    }
    
    private func sendPublishserState(state: Bool) {
        DispatchQueue.main.async {
            self.habitPublisher?.send(state)
        }
    }
    
    private func setErrorState(errorMessage: String) {
        DispatchQueue.main.async {
            self.uiState = .error(errorMessage)
        }
    }
    
}
