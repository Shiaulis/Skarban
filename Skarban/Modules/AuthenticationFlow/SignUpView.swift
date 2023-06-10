//
//  SignUpView.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import SwiftUI

struct SignUpView: View {

    // MARK: - Properties -

    @State var email: String = ""
    @State var password: String = ""
    private let viewModel: SignUpViewModel

    // MARK: - Init -

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body -

    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.title)
            TextField("email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("Sign In") {
                self.viewModel.signUp(email: self.email, password: self.password)
            }
            .buttonStyle(.bordered)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: .init(authenticationController: InMemoryAuthenticationController()))
    }
}
