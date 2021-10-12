import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                Form {
                    TextField("Nome ou Email", text: $viewModel.attributes.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Senha", text: $viewModel.attributes.password)
                }
                
                if viewModel.state == .loading {
                    LoadableView()
                }
            }
            
            Button("Acessar minha conta") {
                withAnimation { viewModel.login() }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
            .disabled(viewModel.canSubmit.negated)
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewDisplayName("Initial State")
            LoginView(viewModel: .init(state: .loading))
                .previewDisplayName("Loading State")
        }
    }
}
