//
//  SignUpView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    

    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
                VStack(
                    alignment: .center,
                    spacing: 20,
                    content: {
                        VStack(
                            alignment: .leading,
                            spacing: 8,
                            content: {
                                HabitLogo()
                                headerView
                                fullNameField
                                emailField
                                passwordField
                                documentField
                                phoneField
                                birthdayField
                                genderField
                                savebutton
                            }
                        )
                        Spacer()
                    }
                ).padding(.horizontal, 8)
            }.padding()
            
            if case SignUpUiState.error(let error) = viewModel.uiState {
                HabitErrorAlert(error: error)
            }
        }
    }
}

extension SignUpView {
    var headerView: some View {
        HabitTextTitleView(text: "Sign Up")
    }
}

extension SignUpView {
    var fullNameField: some View {
        HabitEditTextView(
            text: $viewModel.fullName,
            placeHolder: "Complete Name",
            error: "Invalid Name",
            failure: !viewModel.fullName.isTextValidLenght(minLenght: 5),
            keyboard: .numbersAndPunctuation,
            autocapitalization: .words
        )
    }
}

extension SignUpView {
    var emailField: some View {
        HabitEditTextView(
            text: $viewModel.email,
            placeHolder: "E-mail",
            error: "Invalid E-mail",
            failure: !viewModel.email.isEmail(),
            keyboard: .emailAddress
        )
    }
}

extension SignUpView {
    var passwordField: some View {
        HabitSecureEditTextView(
            text: $viewModel.password,
            placeHolder: "Password",
            error: "Password must have at leas 5 characters",
            failure: !viewModel.password.isTextValidLenght(minLenght: 5)
        )
    }
}

extension SignUpView {
    var documentField: some View {
        HabitEditTextView(
            text: $viewModel.document,
            placeHolder: "Document",
            mask: Mask.MaskPattern.brazilianCpf,
            error: "Invalid document",
            failure: !viewModel.document.isTextValidLenght(minLenght: 5),
            keyboard: .numbersAndPunctuation
        )
    }
}

extension SignUpView {
    var phoneField: some View {
        HabitEditTextView(
            text: $viewModel.phone,
            placeHolder: "Phone",
            mask: Mask.MaskPattern.phone,
            error: "Invalid phone",
            failure: !viewModel.phone.isTextValidLenght(minLenght: 5),
            keyboard: .phonePad
        )
    }
}

extension SignUpView {
    var birthdayField: some View {
        DatePicker("DOB",
                   selection: $viewModel.birthday,
                   displayedComponents: .date
        )
        .datePickerStyle(CompactDatePickerStyle())
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { gender in
                Text(gender.rawValue)
                    .tag(gender)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
}

extension SignUpView {
    var savebutton: some View {
        HabitLoadingButtonView(
            action: {
                viewModel.signUp()
            },
            buttonText: "SignUp",
            showProgress: !viewModel.email.isEmail() || 
            !viewModel.password.isTextValidLenght(minLenght: 5) ||
            !viewModel.document.isTextValidLenght(minLenght: 5) ||
            !viewModel.fullName.isTextValidLenght(minLenght: 5) ||
            !viewModel.phone.isTextValidLenght(minLenght: 5),
            disabled: self.viewModel.uiState == SignUpUiState.loading
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignUpViewModel(signUpInteractor: SignUpInteractor())
        
        SignUpView(viewModel: viewModel)
    }
}

