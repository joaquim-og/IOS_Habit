//
//  HabitLoadingButtonView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 15/02/24.
//

import SwiftUI

struct HabitLoadingButtonView: View {
    
    let buttonText: String
    var action: () -> Void
    var disabled: Bool = false
    var showProgressBar: Bool = false
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                HabitTextBoldView(text: showProgressBar ? " ": buttonText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .background(disabled || showProgressBar ? Color("lightOrange"):Color.orange
                    )
                    .foregroundColor(.white)
                    .cornerRadius(4.0)
            }).disabled(disabled || showProgressBar)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgressBar ? 1 : 0)
        }
    }
}

struct HabitLoadingButtonViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            VStack {
                HabitLoadingButtonView(
                    buttonText: "Xablau",
                    action:{
                        debugPrint("Xablau o botão clicado")
                    }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}
