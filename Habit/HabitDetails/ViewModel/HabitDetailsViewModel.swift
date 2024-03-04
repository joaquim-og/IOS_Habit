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
    
    
    @Published var uiState: HabitDetailUiState = .loading
    @Published var value = ""
    
    let id: Int
    let name: String
    let label: String
    
    private let interactor: HabitDetailInteractor
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
        
    func onAppear() {
        setLoadingState()
//        habitCancellable = interactor.fetchHabits()
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
//            if successResponse.isEmpty {
//                self.setFullListState(modelList: [])
//                
//                self.title = ""
//                self.headline = "Fique ligado!"
//                self.description = "Você ainda nào possui hábitos"
//            } else {
//                self.setFullListState(modelList: self.mapHabitResponseList(responseList: successResponse))
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
