//
//  SplasView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 22/03/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var state: SplashUistate = .loading
    
    var body: some View {
        switch state {
        case .loading:
            loadingView()
        case .goToSignScreen:
            Text("load login")
        case .goToHomeScreen:
            Text("load home")
        case .error(let errorMsg):
            Text("error \(errorMsg)")
        }
    }
}

extension SplashView {
    func loadingView() -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

