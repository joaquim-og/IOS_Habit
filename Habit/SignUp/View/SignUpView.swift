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
    @State var birthday = ""
    
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
                                savebutton
                            }
                        )
                        Spacer()
                    }
                ).padding(.horizontal, 8)
            }.padding()
        }
    }
}

extension SignUpView {
    var headerView: some View {
        Text("Cadastro")
            .foregroundColor(.black)
            .font(Font.system(.title).bold())
            .padding(.bottom, 8)
    }
}

extension SignUpView {
    var fullNameField: some View {
        TextField("", text: $fullName)
            .border(Color.black)
    }
}

extension SignUpView {
    var emailField: some View {
        TextField("", text: $email)
            .border(Color.black)
    }
}

extension SignUpView {
    var passwordField: some View {
        SecureField("", text: $password)
            .border(Color.orange)
    }
}

extension SignUpView {
    var documentField: some View {
        TextField("", text: $document)
            .border(Color.black)
    }
}

extension SignUpView {
    var phoneField: some View {
        TextField("", text: $phone)
            .border(Color.black)
    }
}

extension SignUpView {
    var birthdayField: some View {
        TextField("", text: $birthday)
            .border(Color.black)
    }
}

extension SignUpView {
    var savebutton: some View {
        Button("Realizar o seu cadastro") {
            "so ppra arrumar o delete"
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignUpViewModel()
        
        SignUpView(viewModel: viewModel)
    }
}

