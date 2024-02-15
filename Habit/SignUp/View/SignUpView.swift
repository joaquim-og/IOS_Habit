//
//  SignUpView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 30/10/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    //TODO: move to VM
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = Date()
    @State var gender = Gender.male
    
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
        HabitTextTitleView(text: "Cadastro")
    }
}

extension SignUpView {
    var fullNameField: some View {
        HabitEditTextView(
            text: $fullName,
            placeHolder: "Nome Completo",
            error: "Nome invalido",
            failure: !fullName.isTextValidLenght(minLenght: 5),
            keyboard: .numbersAndPunctuation
        )
    }
}

extension SignUpView {
    var emailField: some View {
        HabitEditTextView(
            text: $email,
            placeHolder: "E-mail",
            error: "E-mail invalido",
            failure: !email.isEmail(),
            keyboard: .emailAddress
        )
    }
}

extension SignUpView {
    var passwordField: some View {
        HabitSecureEditTextView(
            text: $password,
            placeHolder: "Password",
            error: "Password deve conter 5 caracteres no minimo",
            failure: !password.isTextValidLenght(minLenght: 5)
        )
    }
}

extension SignUpView {
    var documentField: some View {
        HabitEditTextView(
            text: $document,
            placeHolder: "Documento",
            error: "Documento invalido",
            failure: !document.isTextValidLenght(minLenght: 5),
            keyboard: .numbersAndPunctuation
        )
    }
}

extension SignUpView {
    var phoneField: some View {
        HabitEditTextView(
            text: $phone,
            placeHolder: "Telefone",
            error: "Telefone invalido",
            failure: !phone.isTextValidLenght(minLenght: 5),
            keyboard: .phonePad
        )
    }
}

extension SignUpView {
    var birthdayField: some View {
        DatePicker("Data de nascimento",
                   selection: $birthday,
                   displayedComponents: .date
        )
        .datePickerStyle(CompactDatePickerStyle())
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $gender) {
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
            buttonText: "Realizar o seu cadastro",
            action: {
                viewModel.signUp()
            },
            disabled: !email.isEmail() || 
            !password.isTextValidLenght(minLenght: 5) ||
            !document.isTextValidLenght(minLenght: 5) ||
            !fullName.isTextValidLenght(minLenght: 5) ||
            !phone.isTextValidLenght(minLenght: 5),
            showProgressBar: self.viewModel.uiState == SignUpUiState.loading
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignUpViewModel()
        
        SignUpView(viewModel: viewModel)
    }
}

