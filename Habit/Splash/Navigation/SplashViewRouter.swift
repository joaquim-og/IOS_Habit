//
//  SplashViewRouter.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 09/10/23.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSignInView() -> some View {
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
    
}
