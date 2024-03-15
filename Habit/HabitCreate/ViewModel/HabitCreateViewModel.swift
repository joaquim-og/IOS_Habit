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
    
    
    @Published var uiState: HabitsCreateUiState = .none
    @Published var name: String = ""
    @Published var label: String = ""
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = nil
            
    private let interactor: HabitsCreateInteractor
    private var habitCreateCancellable: AnyCancellable?
    var habitCreatePublisher: PassthroughSubject<Bool, Never>?
    
    init(interactor: HabitsCreateInteractor){
        self.interactor = interactor
        
   }
    
    deinit {
        habitCreateCancellable?.cancel()
    }
    
    func saveNewHabit() {
        setLoadingState()
        habitCreateCancellable = interactor.save(request: HabitCreateRequest(imageData: imageData, name: name, label: label))
            .receive(on: DispatchQueue.main)
            .sink { onComplete in
                switch (onComplete) {
                case .failure(let appError):
                    self.setErrorState(errorMessage: appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.setSuccessState()
                self.habitCreatePublisher?.send(true)
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
    
    private func setErrorState(errorMessage: String) {
        DispatchQueue.main.async {
            self.uiState = .error(errorMessage)
        }
    }
    
}
