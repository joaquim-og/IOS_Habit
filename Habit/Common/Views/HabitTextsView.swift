//
//  HabitTextsView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 15/02/24.
//

import SwiftUI

struct HabitTextBoldView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(Font.system(.title3).bold())
    }
}

struct HabitTextTitleView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(Font.system(.title).bold())
            .padding(.bottom, 8)
    }
}

struct HabitTextNormalView: View {
    let text: String
    let fontSize: CGFloat = 18
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize))
    }
}

struct HabitTextBoldViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            VStack {
                HabitTextBoldView(text: "Xablau bold").padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}

struct HabitTexNormalViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            VStack {
                HabitTextNormalView(text: "Xablau normal").padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}

struct HabitTextTitleViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            VStack {
                HabitTextTitleView(text: "Xablau title").padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(colorScheme)
        }
    }
}

