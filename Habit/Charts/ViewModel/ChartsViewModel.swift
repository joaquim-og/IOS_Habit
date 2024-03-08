//
//  ChartViewModel.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 07/03/24.
//

import Foundation
import Combine
import DGCharts

class ChartsViewModel: ObservableObject {
    
    
    @Published var uiState: ChartsUiState = .loading
    
    private var habitId: Int
    
    private let interactor: ChartsInteractor
    
    private var chartsCancellable: AnyCancellable?
    
    @Published var entries: [ChartDataEntry] = []
    
    @Published var dates: [String] = []

    
    init(
        interactor: ChartsInteractor,
        habitId: Int
    ){
        self.interactor = interactor
        self.habitId = habitId
    }
    
    deinit {
        chartsCancellable?.cancel()
    }
    
    func onAppear() {
        setLoadingState()
        chartsCancellable = interactor.fetchHabitValue(habitId: self.habitId)
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
                if (successResponse.isEmpty) {
                    self.setUiState(newState: .emptyChart)
                } else {
                    self.dates = successResponse.map { $0.createdDate }
                                        
                    self.entries = zip(successResponse.startIndex..<successResponse.endIndex, successResponse).map { index, response in
                        ChartDataEntry(x: Double(index), y: Double(response.value))
                    }
                    self.setUiState(newState: .fullChart)
                }
            }
    }
    
  
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setUiState(newState: ChartsUiState) {
        DispatchQueue.main.async {
            self.uiState = newState
        }
    }
       
    private func setErrorState(errorMessage: String) {
        DispatchQueue.main.async {
            self.uiState = .error(errorMessage)
        }
    }
    
}
