//
//  ButtonStyle.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 27/02/24.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(4.0)
    }
    
}
