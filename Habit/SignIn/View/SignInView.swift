//
//  SiginView.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 09/10/23.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
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
                                        Text("SignIn")
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
                        .navigationBarTitle("SignIn", displayMode: .inline)
                        .navigationBarHidden(navigationHidden)
                }
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        HabitEditTextView(
            text: $viewModel.email,
            placeHolder: "E-mail",
            error: "Invalid e-mail",
            failure: !viewModel.email.isEmail(),
            keyboard: .emailAddress
        )
    }
}

extension SignInView {
    var passwordField: some View {
        HabitSecureEditTextView(
            text: $viewModel.password,
            placeHolder: "Password",
            error: "Password must have at leas 5 characters",
            failure: !viewModel.password.isTextValidLenght(minLenght: 5)
        )
    }
}

extension SignInView {
    var enterbutton: some View {
        HabitLoadingButtonView(
            action: {
                viewModel.login()
            },
            buttonText: "SignIn",
            showProgress: self.viewModel.uiState == SignInUiState.loading,
            disabled: self.viewModel.uiState == SignInUiState.loading
        )
    }
}


extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Don't have an account?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack{
                NavigationLink(
                    destination: viewModel.navigateToSignUpView(),
                    tag: 1,
                    selection: $action,
                    label: { EmptyView() }
                )
                
                Button("SignUp") {
                    self.action = 1
                }
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            let viewModel = SignInViewModel(interactor: SignInInteractor())
            
            SignInView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme(colorScheme)
        }
    }
}
