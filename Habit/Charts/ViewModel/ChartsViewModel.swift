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
    
    private var habitId: Int?
    
    private let interactor: ChartsInteractor
    
    private var chartsCancellable: AnyCancellable?
    
    @Published var entries: [ChartDataEntry] = [
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 2.0, y: 1.0),
        ChartDataEntry(x: 3.0, y: 5.0),
        ChartDataEntry(x: 4.0, y: 4.0),
        ChartDataEntry(x: 5.0, y: 9.0),
        ChartDataEntry(x: 6.0, y: 45.0),
        ChartDataEntry(x: 7.0, y: 3.0),
        ChartDataEntry(x: 8.0, y: 4.0),
        ChartDataEntry(x: 9.0, y: 2.0),
        ChartDataEntry(x: 10.0, y: 7.0),
    ]
    
    @Published var dates = [
        "2024-03-01",
        "2024-03-02",
        "2024-03-03",
        "2024-03-04",
        "2024-03-05",
        "2024-03-06",
        "2024-03-07",
        "2024-03-09",
        "2024-03-10",
    ]

    
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
    
    func getUserProfileData() {
        setLoadingState()
//        chartsCancellable = interactor.fetchUser()
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
//                self.setSuccessState()
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
