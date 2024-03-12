//
//  HabitCreateViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 12/03/24.
//

import Foundation
import Combine
import SwiftUI

class HabitCreateViewModel: ObservableObject {
    
    
    @Published var uiState: HabitsCreateUiState = .loading
    @Published var name: String = ""
    @Published var label: String = ""
            
    private let interactor: HabitsCreateInteractor
    private var habitCreateCancellable: AnyCancellable?
    var habitCreatePublisher: PassthroughSubject<Bool, Never>?
    
    init(interactor: HabitsCreateInteractor){
        self.interactor = interactor
        
   }
    
    deinit {
        habitCreateCancellable?.cancel()
    }
    
    func onAppear() {
        setLoadingState()
//        habitCancellable = interactor.fetchHabits()
//            .receive(on: DispatchQueue.main)
//            .sink { onComplete in
//                switch (onComplete) {
//                case .failure(let appError):
//                    self.setErrorState(errorMessage: appError.message)
//                    break
//                case .finished:
//                    break
//                }
//            } receiveValue: { successResponse in
//                if successResponse.isEmpty {
//                    self.setFullListState(modelList: [])
//                    
//                    self.title = ""
//                    self.headline = "Fique ligado!"
//                    self.description = "Você ainda nào possui hábitos"
//                } else {
//                    self.setFullListState(modelList: self.mapHabitResponseList(responseList: successResponse))
//                }
//            }
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
