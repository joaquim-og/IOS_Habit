//
//  HabitLoadingButtonView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 15/02/24.
//

import SwiftUI

struct HabitLoadingButtonView: View {
    
    var action: () -> Void
    var buttonText: String
    var showProgress: Bool = false
    var disabled: Bool = false
    
    var body: some View {
      ZStack {
        Button(action: {
          action()
        }, label: {
          Text(showProgress ? " " : buttonText)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(disabled ? Color("lightOrange") : Color.orange)
            .foregroundColor(.white)
            .cornerRadius(4.0)
        }).disabled(disabled || showProgress)
        
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
          .opacity(showProgress ? 1 : 0)
      }
    }
  }

  struct HabitLoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        VStack {
            HabitLoadingButtonView(action: {
            print("Xablau")
          },
          buttonText: "Entrar",
          showProgress: false,
          disabled: false)
        }.padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme($0)
      }
      
    }
  }
