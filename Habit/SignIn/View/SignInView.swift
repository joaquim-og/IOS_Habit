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
        NavigationView{
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
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(.orange)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                numberField
                                passwordField
                                enterbutton
                                registerLink
                            }
                        )
                    }
                )
            }.frame(maxWidth:.infinity, maxHeight: .infinity)
                .padding(.horizontal, 32)
                .background(Color.white)
                .navigationBarTitle("Login", displayMode: .inline)
                .navigationBarHidden(navigationHidden)
        }
    }
}

extension SignInView {
    var numberField: some View {
        TextField("", text: $email)
            .border(Color.black)
    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("", text: $password)
            .border(Color.orange)
    }
}

extension SignInView {
    var enterbutton: some View {
        Button("Entrar") {
            
        }
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
                    destination: Text("Tela de cadastro") ,
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
        let viewModel = SignInViewModel()
        
        SignInView(viewModel: viewModel)
    }
}
