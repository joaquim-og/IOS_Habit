//
//  HabitCreateView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 12/03/24.
//

import SwiftUI

struct HabitCreateView: View {
    
    @ObservedObject var viewModel: HabitCreateViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var shouldPresentCamera = false
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            addImage
            addName
            addLabel
            addActionButtons
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
    }
}

extension HabitCreateView {
    var addImage: some View {
        VStack(alignment: .center, spacing: 12) {
            Button(
                action: {
                    shouldPresentCamera = true
                },
                label: {
                    VStack {
                        viewModel.image!
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.orange)
                        
                        Text("Tap here to send")
                            .foregroundColor(Color.orange)
                    }
                }
            )
            .padding(.bottom, 12)
            .sheet(
                isPresented: $shouldPresentCamera,
                content: {
                    ImagePickerView(
                        image: self.$viewModel.image,
                        imageData: self.$viewModel.imageData,
                        isPresented: $shouldPresentCamera,
                        sourceType: .camera
                    )
                }
            )
        }
    }
}

extension HabitCreateView {
    var addName: some View {
        VStack {
            TextField("Write here the habit name", text: $viewModel.name)
                .multilineTextAlignment(.center)
                .textFieldStyle(PlainTextFieldStyle())
            
            Divider()
                .frame(height: 1)
                .background(Color.gray)
        }.padding(.horizontal, 32)
    }
}

extension HabitCreateView {
    var addLabel: some View {
        VStack {
            TextField("Write here the habit measure", text: $viewModel.label)
                .multilineTextAlignment(.center)
                .textFieldStyle(PlainTextFieldStyle())
            
            Divider()
                .frame(height: 1)
                .background(Color.gray)
        }.padding(.horizontal, 32)
        
    }
}

extension HabitCreateView {
    var addActionButtons: some View {
        VStack {
            HabitLoadingButtonView(
                action: {
                    viewModel.saveNewHabit()
                },
                buttonText: "Save",
                showProgress: self.viewModel.uiState == .loading,
                disabled: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            
            Spacer()
        }
    }
}

struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            let viewModel = HabitCreateViewModel(
                interactor: HabitsCreateInteractor()
            )
            
            
            HabitCreateView(viewModel: viewModel)
                .preferredColorScheme($0)
        }
    }
}
