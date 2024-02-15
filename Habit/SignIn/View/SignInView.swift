//
//  SiginView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 09/10/23.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var email = ""
    @State var password = ""
    
    @State var action: Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        
        ZStack {
            if case SignInUiState.goToHomeScreen = viewModel.uiState {
                viewModel.navigateToHomeView()
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(
                            alignment: .center,
                            spacing: 20,
                            content: {
                                Spacer(minLength: 36)
                                VStack(
                                    alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                                    spacing: 8,
                                    content: {
                                        HabitLogo()
                                        Text("Login")
                                            .foregroundColor(.orange)
                                            .font(Font.system(.title).bold())
                                            .padding(.bottom, 8)
                                        
                                        emailField
                                        passwordField
                                        enterbutton
                                        registerLink
                                    }
                                )
                                
                                if case SignInUiState.error(let error) =
                                    viewModel.uiState{
                                    HabitErrorAlert(error: error)
                                }
                            }
                        )
                    }.frame(maxWidth:.infinity, maxHeight: .infinity)
                        .padding(.horizontal, 32)
                        .navigationBarTitle("Login", displayMode: .inline)
                        .navigationBarHidden(navigationHidden)
                }
            }
        }
    }
}

extension SignInView {
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

extension SignInView {
    var passwordField: some View {
        HabitSecureEditTextView(
            text: $password,
            placeHolder: "Password",
            error: "Password deve conter 5 caracteres no minimo",
            failure: !password.isTextValidLenght(minLenght: 5)
        )
    }
}

extension SignInView {
    var enterbutton: some View {
        HabitLoadingButtonView(
            buttonText: "Entrar",
            action: {
                viewModel.login(email: email, password: password)
            },
            disabled: !email.isEmail() || !password.isTextValidLenght(minLenght: 5),
            showProgressBar: self.viewModel.uiState == SignInUiState.loading
        )
    }
}


extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui conta?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack{
                NavigationLink(
                    destination: viewModel.navigateToSignUpView(),
                    tag: 1,
                    selection: $action,
                    label: { EmptyView() }
                )
                
                Button("Realize seu cadastro") {
                    self.action = 1
                }
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            let viewModel = SignInViewModel()
            
            SignInView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme(colorScheme)
        }
    }
}
