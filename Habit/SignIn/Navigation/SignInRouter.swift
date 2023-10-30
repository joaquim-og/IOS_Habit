//
//  SigInRouter.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI

enum SignInViewRouter {
    
    static func navigateToHomeView() -> some View {
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
    
}
