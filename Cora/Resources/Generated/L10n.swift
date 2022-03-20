// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Home {
    /// Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos.
    internal static let description = L10n.tr("Localizable", "Home.Description")
    /// Poderosamente simples
    internal static let subtitle = L10n.tr("Localizable", "Home.Subtitle")
    /// Conta Digital PJ
    internal static let title = L10n.tr("Localizable", "Home.Title")
    internal enum Button {
      /// Já sou cliente
      internal static let login = L10n.tr("Localizable", "Home.Button.Login")
      /// Quero fazer parte!
      internal static let signup = L10n.tr("Localizable", "Home.Button.Signup")
    }
  }

  internal enum Login {
    /// Esqueci minha senha
    internal static let forgotPassword = L10n.tr("Localizable", "Login.ForgotPassword")
    /// Login Cora
    internal static let title = L10n.tr("Localizable", "Login.Title")
    /// Bem-vindo de volta!
    internal static let welcome = L10n.tr("Localizable", "Login.Welcome")
    internal enum Button {
      /// Próximo
      internal static let next = L10n.tr("Localizable", "Login.Button.Next")
    }
    internal enum Question {
      /// Qual seu CPF?
      internal static let document = L10n.tr("Localizable", "Login.Question.Document")
      /// Digite sua senha de acesso
      internal static let password = L10n.tr("Localizable", "Login.Question.Password")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
