//
//  SigInRouter.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    
    static func navigateToHomeViewFromSignIn() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }    
    
    static func navigateToHomeViewFromSignIn(homeViewModel: HomeViewModel) -> some View {
        return HomeView(viewModel: homeViewModel)
    }
    
    static func navigateToSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(signUpInteractor: SignUpInteractor())
        viewModel.signUpPublisher = publisher
        return SignUpView(viewModel: viewModel)
    }
    
}
