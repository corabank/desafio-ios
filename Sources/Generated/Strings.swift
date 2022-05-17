// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {

  internal enum Home {
    /// Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos.
    internal static let description = Strings.tr("Localizable", "home.description")
    /// Já sou cliente
    internal static let signIn = Strings.tr("Localizable", "home.signIn")
    /// Quero fazer parte!
    internal static let signUp = Strings.tr("Localizable", "home.signUp")
    /// Conta Digital PJ/nPoderosamente simples
    internal static let title = Strings.tr("Localizable", "home.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = CoraResources.resourcesBundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
