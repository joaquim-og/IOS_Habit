//
//  HomeView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(
                    alignment: .center,
                    spacing: 20,
                    content: {
                        HabitLogo()
                        Spacer(minLength: 36)
                        headerView
                    }
                )
            }
        }
    }
}

extension HomeView {
    var headerView: some View {
        Text("Xablau aqui o header")
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        
        HomeView(viewModel: viewModel)
    }
}

