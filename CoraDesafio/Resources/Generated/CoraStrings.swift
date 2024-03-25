// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum CoraStrings {
  internal enum Commons {
    /// R$
    internal static let concurrency = CoraStrings.tr("Localizable", "Commons.concurrency", fallback: "R$")
    /// Data
    internal static let date = CoraStrings.tr("Localizable", "Commons.date", fallback: "Data")
    /// Para
    internal static let `for` = CoraStrings.tr("Localizable", "Commons.for", fallback: "Para")
    /// Entrar
    internal static let getIn = CoraStrings.tr("Localizable", "Commons.getIn", fallback: "Entrar")
    /// Próximo
    internal static let next = CoraStrings.tr("Localizable", "Commons.next", fallback: "Próximo")
    /// De
    internal static let of = CoraStrings.tr("Localizable", "Commons.of", fallback: "De")
    /// Valor
    internal static let valor = CoraStrings.tr("Localizable", "Commons.valor", fallback: "Valor")
    internal enum Navigation {
      /// Login Cora
      internal static let loginCora = CoraStrings.tr("Localizable", "Commons.Navigation.loginCora", fallback: "Login Cora")
    }
  }
  internal enum ExtractDetailsView {
    /// Descrição
    internal static let description = CoraStrings.tr("Localizable", "ExtractDetailsView.description", fallback: "Descrição")
    /// Detalhes da transferência
    internal static let navigationTitle = CoraStrings.tr("Localizable", "ExtractDetailsView.navigationTitle", fallback: "Detalhes da transferência")
    internal enum Button {
      /// Compartilhar comprovante
      internal static let title = CoraStrings.tr("Localizable", "ExtractDetailsView.button.title", fallback: "Compartilhar comprovante")
    }
  }
  internal enum ExtractListView {
    /// Extrato
    internal static let navigationTitle = CoraStrings.tr("Localizable", "ExtractListView.navigationTitle", fallback: "Extrato")
    internal enum Button {
      /// Tudo
      internal static let all = CoraStrings.tr("Localizable", "ExtractListView.button.all", fallback: "Tudo")
      /// Entrada
      internal static let entrency = CoraStrings.tr("Localizable", "ExtractListView.button.entrency", fallback: "Entrada")
      /// Saida
      internal static let exit = CoraStrings.tr("Localizable", "ExtractListView.button.exit", fallback: "Saida")
      /// Futuro
      internal static let future = CoraStrings.tr("Localizable", "ExtractListView.button.future", fallback: "Futuro")
    }
  }
  internal enum Fonts {
    /// Lato-Bold
    internal static let bold = CoraStrings.tr("Localizable", "Fonts.bold", fallback: "Lato-Bold")
    /// Lato-Regular
    internal static let regular = CoraStrings.tr("Localizable", "Fonts.regular", fallback: "Lato-Regular")
  }
  internal enum Icons {
    /// arrow.left
    internal static let arrowLeft = CoraStrings.tr("Localizable", "Icons.arrowLeft", fallback: "arrow.left")
    /// arrow.right
    internal static let arrowRight = CoraStrings.tr("Localizable", "Icons.arrowRight", fallback: "arrow.right")
    /// chevron.left
    internal static let chevronLeft = CoraStrings.tr("Localizable", "Icons.chevronLeft", fallback: "chevron.left")
    /// square.and.arrow.up
    internal static let shareUp = CoraStrings.tr("Localizable", "Icons.shareUp", fallback: "square.and.arrow.up")
    /// square.and.arrow.down
    internal static let signOut = CoraStrings.tr("Localizable", "Icons.signOut", fallback: "square.and.arrow.down")
  }
  internal enum LoginView {
    /// Qual seu CPF?
    internal static let cpfDesciption = CoraStrings.tr("Localizable", "LoginView.cpfDesciption", fallback: "Qual seu CPF?")
    /// Bem-vindo de volta!
    internal static let welcomeDescription = CoraStrings.tr("Localizable", "LoginView.welcomeDescription", fallback: "Bem-vindo de volta!")
  }
  internal enum OnboardingView {
    /// Sua empresa livre burocracias e de taxas para
    /// gerar boletos, fazer transferências e
    /// pagamentos.
    internal static let descriptionLabel = CoraStrings.tr("Localizable", "OnboardingView.descriptionLabel", fallback: "Sua empresa livre burocracias e de taxas para\ngerar boletos, fazer transferências e\npagamentos.")
    /// Já sou cliente
    internal static let loginButton = CoraStrings.tr("Localizable", "OnboardingView.loginButton", fallback: "Já sou cliente")
    /// Quero fazer parte!
    internal static let registerButton = CoraStrings.tr("Localizable", "OnboardingView.registerButton", fallback: "Quero fazer parte!")
    /// Conta Digital PJ
    /// Poderosamente simples
    internal static let titleLabel = CoraStrings.tr("Localizable", "OnboardingView.titleLabel", fallback: "Conta Digital PJ\nPoderosamente simples")
    /// Conta Digital PJ
    internal static let titleLabelBold = CoraStrings.tr("Localizable", "OnboardingView.titleLabelBold", fallback: "Conta Digital PJ")
  }
  internal enum PasswordView {
    /// Esqueci minha senha
    internal static let forgotPasswordButton = CoraStrings.tr("Localizable", "PasswordView.forgotPasswordButton", fallback: "Esqueci minha senha")
    /// Digite sua senha de acesso
    internal static let titleLabel = CoraStrings.tr("Localizable", "PasswordView.titleLabel", fallback: "Digite sua senha de acesso")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension CoraStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
