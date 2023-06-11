//
//  LoginView.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {

    // MARK: - Properties -

    @Environment(\.colorScheme) var colorScheme

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
                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField("password", text: $password)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    self.viewModel.login(using: self.email, password: self.password)
                }
            Button("Login") {
                self.viewModel.login(using: self.email, password: self.password)
            }
            .buttonStyle(.bordered)
            Divider()
            Button("Sign up") {
                self.viewModel.signUp()
            }
            .buttonStyle(.borderedProminent)
            if colorScheme.self == .dark {
                SignInButton(SignInWithAppleButton.Style.whiteOutline)
            }
            else {
                SignInButton(SignInWithAppleButton.Style.black)
            }
        }
        .padding()
        .onAppear {
            self.viewModel.appear()
        }
        .onDisappear {
            self.viewModel.disappear()
        }
        .interactiveDismissDisabled()
    }

    private func SignInButton(_ type: SignInWithAppleButton.Style) -> some View{
        return SignInWithAppleButton(.continue) { request in
            request.requestedScopes = LoginViewModel.requestScopes
        } onCompletion: { result in
            self.viewModel.handleSignInResult(with: result)
        }
        .frame(width: 280, height: 40, alignment: .center)
        .signInWithAppleButtonStyle(type)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init(authenticationController: InMemoryAuthenticationController()))
    }
}
