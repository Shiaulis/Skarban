//
//  LoginView.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import SwiftUI

struct LoginView: View {

    // MARK: - Properties -

    @State var email: String = ""
    @State var password: String = ""
    private let viewModel: LoginViewModel

    // MARK: - Init -

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body -

    var body: some View {
        VStack {
            Text("Login")
                .font(.title)
            TextField("email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("Login") {
                self.viewModel.login(using: self.email, password: self.password)
            }
            .buttonStyle(.bordered)
            Divider()
            Button("Sign up") {
                self.viewModel.signUp()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
        .onAppear {
            self.viewModel.appear()
        }
        .onDisappear {
            self.viewModel.disappear()
        }
        .interactiveDismissDisabled()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init(authenticationController: InMemoryAuthenticationController()))
    }
}
