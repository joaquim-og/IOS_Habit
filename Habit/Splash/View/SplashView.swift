//
//  SplasView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 22/03/23.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group{
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignScreen:
                Text("load login")
            case .goToHomeScreen:
                Text("load home")
            case .error(let errorMsg):
                loadingView(error: errorMsg)
            }
        }.onAppear {
            viewModel.onAppear()
        }
    }
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
            
            if let error = error {
                Text("").alert(isPresented: .constant(true)) {
                    Alert(title: Text("Habit"),
                          message: Text(error),
                          dismissButton: .default(Text("ok")) {}
                    )
                }
            }
            
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SplashViewModel()
        
        SplashView(viewModel: viewModel)
    }
}

