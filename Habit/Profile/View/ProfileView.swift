//
//  ProfileView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 05/03/24.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        !viewModel.userName.isTextValidLenght(minLenght: 5) ||
        !viewModel.userPhone.isTextValidLenght(minLenght: 5)
    }
    
    var body: some View {
        ZStack {
            if case ProfileUiState.loading = viewModel.uiState {
                progressView
            } else {
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
                    }
                    .navigationBarTitle(
                        Text("Edit profile"),
                        displayMode: .automatic
                    )
                    .navigationBarItems(
                        trailing:
                            Button(
                                action: {
                                    viewModel.updateUserProfileData()
                                },
                                label: {
                                    if case ProfileUiState.updateLoading = viewModel.uiState {
                                        progressView
                                    } else {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.orange)
                                    }
                                }
                            )
                            .opacity(disableDone ? 0 : 1)
                            .alert(
                                isPresented:
                                        .constant(viewModel.uiState == .updateSuccess),
                                content: {
                                    Alert(
                                        title: Text("Habit"),
                                        message: Text("Profile successfuly updated"),
                                        dismissButton: .default(
                                            Text("Ok"),
                                            action: {
                                                viewModel.setUpdateState(state: .none)
                                            }
                                        )
                                    )
                                }
                            )
                    )
                }
            }
            
            if case ProfileUiState.error(let msg) = viewModel.uiState {
                Text("")
                    .alert(
                        isPresented: .constant(true),
                        content: {
                            Alert(
                                title: Text("Ops \(msg)"),
                                message: Text("Try again?"),
                                primaryButton: .default(Text("Yes")) {
                                    viewModel.getUserProfileData()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    )
            }
            
            if case ProfileUiState.updateError(let msg) = viewModel.uiState {
                Text("")
                    .alert(
                        isPresented: .constant(true),
                        content: {
                            Alert(
                                title: Text("Ops \(msg)"),
                                message: Text("Try again?"),
                                primaryButton: .default(Text("Yes")) {
                                    viewModel.updateUserProfileData()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    )
            }
            
        }.onAppear {
            viewModel.getUserProfileData()
        }
    }
}

extension ProfileView {
    var progressView: some View {
        ProgressView()
    }
}

extension ProfileView {
    var userNameField: some View {
        VStack{
            HStack {
                Text("Name")
                Spacer()
                TextField("Tap your name", text: $viewModel.userName)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
            }
            if (!viewModel.userName.isTextValidLenght(minLenght: 5)) {
                Text("Invalid Name").foregroundColor(.red).multilineTextAlignment(.trailing)
            }
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
            ProfileEditTextView(
                text: $viewModel.userDocument,
                mask: Mask.MaskPattern.brazilianCpf
            )
            .disabled(true)
            .foregroundColor(Color.gray)
        }
    }
}

extension ProfileView {
    var userPhoneField: some View {
        VStack {
            HStack {
                Text("Phone")
                Spacer()
                ProfileEditTextView(
                    text: $viewModel.userPhone,
                    placeHolder: "Tap your phone",
                    mask: Mask.MaskPattern.phone
                )
                .keyboardType(.alphabet)
            }
            if (!viewModel.userPhone.isTextValidLenght(minLenght: 5)) {
                Text("Invalid Phone").foregroundColor(.red).multilineTextAlignment(.trailing)
            }
        }
    }
}

extension ProfileView {
    var userDOBField: some View {
        HStack {
            DatePicker("DOB",
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
