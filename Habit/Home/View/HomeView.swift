//
//  HomeView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.habitView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Habits")
                }.tag(0)
            
            viewModel.habitForChartView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Graphs")
                }.tag(1)
            
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }.tag(2)
        }
        .background(Color.white)
        .accentColor(Color.orange)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        
        HomeView(viewModel: viewModel)
    }
}

