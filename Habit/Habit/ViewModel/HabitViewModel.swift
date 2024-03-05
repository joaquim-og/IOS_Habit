//
//  HabitViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    
    
    @Published var uiState: HabitUiState = .loading
    
    @Published var title: String = ""
    @Published var headline: String = ""
    @Published var description: String = ""
    
    @Published var opened: Bool = false
    
    private let interactor: HabitInteractor
    private var habitCancellable: AnyCancellable?
    private var cancellabeNotify: AnyCancellable?
    private let habitPublisher = PassthroughSubject<Bool, Never>()

    init(interactor: HabitInteractor){
        self.interactor = interactor
        
        cancellabeNotify = habitPublisher.sink(receiveValue: { valueSaved in
            if (valueSaved) {
                self.onAppear()
            }
        })
    }
    
    deinit {
        habitCancellable?.cancel()
        cancellabeNotify?.cancel()
    }
        
    func onAppear() {
        setLoadingState()
        self.opened = true
        habitCancellable = interactor.fetchHabits()
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
            if successResponse.isEmpty {
                self.setFullListState(modelList: [])
                
                self.title = ""
                self.headline = "Fique ligado!"
                self.description = "Você ainda nào possui hábitos"
            } else {
                self.setFullListState(modelList: self.mapHabitResponseList(responseList: successResponse))
            }
        }
    }
    
    private func mapHabitResponseList(responseList: [HabitResponse]) -> [HabitCardViewModel] {
        return responseList.map {
            var stateColor = Color.green
            self.title = "Muito bom!"
            self.headline = "Seus hábitos estão em dia"
            self.description = ""
            
            let lastDate = $0.lastDate?.formatStringToDate(
                sourcePattern: Date.DatesPatterns.YYYYMMDDTHHMMSS
            ) ?? Date()
            
            if lastDate < Date() {
                stateColor = Color.red
                self.title = "Atenção"
                self.headline = "Fique Ligado"
                self.description = "Você está atrasado nos hábitos"
            }
            
            return $0.mapResponseToDomain(stateColor: stateColor, habitPublisher: self.habitPublisher)
        }
        
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setFullListState(modelList: [HabitCardViewModel]) {
        DispatchQueue.main.async {
            if (modelList.isEmpty) {
                self.uiState = .emptyList
            } else {
                self.uiState = .fullList(modelList)}
        }
    }
    
    private func setErrorState(errorMessage: String) {
        DispatchQueue.main.async {
            self.uiState = .error(errorMessage)
        }
    }
    
}
