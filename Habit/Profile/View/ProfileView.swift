//
//  ProfileView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 05/03/24.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    //TODO: (criar a lista de profiles)
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(
                        header: Text("User Data"),
                        content: {
                            userNameField
                            userEmailField
                            userDocumentField
                            userPhoneField
                            userDOBField
                            userGenderField
                        }
                    )
                }
            }.navigationBarTitle(
                Text("Edit profile"),
                displayMode: .automatic
            )
        }
    }
}

extension ProfileView {
    var userNameField: some View {
        HStack {
            Text("Name")
            Spacer()
            TextField("Tap your name", text: $viewModel.userName)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
        }
    }
}

extension ProfileView {
    var userEmailField: some View {
        HStack {
            Text("E-mail")
            Spacer()
            TextField("", text: $viewModel.userEmail)
                .disabled(true)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.trailing)
        }
    }
}

extension ProfileView {
    var userDocumentField: some View {
        HStack {
            Text("Document")
            Spacer()
            TextField("", text: $viewModel.userDocument)
                .disabled(true)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.trailing)
        }
    }
}

extension ProfileView {
    var userPhoneField: some View {
        HStack {
            Text("Phone")
            Spacer()
            TextField("Tap your phone", text: $viewModel.userPhone)
                .keyboardType(.alphabet)
                .multilineTextAlignment(.trailing)
        }
    }
}

extension ProfileView {
    var userDOBField: some View {
        HStack {
            DatePicker("Birth Day",
                       selection: $viewModel.userBirthday,
                       displayedComponents: .date
            )
            .datePickerStyle(CompactDatePickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 16)
        }
    }
}

extension ProfileView {
    var userGenderField: some View {
        NavigationLink(
            destination:
                HabitGenderSelectorView(
                    selectedGender: $viewModel.userGender,
                    title: "Chose your gender",
                    genders: Gender.allCases
                ),
            label: {
                HStack {
                    Text("Gender")
                    Spacer()
                    Text(viewModel.userGender?.rawValue ?? "")
                        .multilineTextAlignment(.trailing)
                }
            }
        )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ProfileView(
                viewModel: ProfileViewModel(
                    interactor: ProfileInteractor()
                )
            )
            .preferredColorScheme($0)
        }
    }
}
