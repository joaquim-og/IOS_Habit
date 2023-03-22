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
            Text("loading")
        case .goToSignScreen:
            Text("load login")
        case .goToHomeScreen:
            Text("load home")
        case .error(let errorMsg):
            Text("error \(errorMsg)")
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

