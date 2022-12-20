// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum BankStatement {
    /// Extrato
    internal static let title = Strings.tr("Localizable", "bankStatement.title", fallback: "Extrato")
    internal enum Segment {
      /// Tudo
      internal static let all = Strings.tr("Localizable", "bankStatement.segment.all", fallback: "Tudo")
      /// Futuro
      internal static let future = Strings.tr("Localizable", "bankStatement.segment.future", fallback: "Futuro")
      /// Entrada
      internal static let input = Strings.tr("Localizable", "bankStatement.segment.input", fallback: "Entrada")
      /// Saída
      internal static let output = Strings.tr("Localizable", "bankStatement.segment.output", fallback: "Saída")
    }
  }
  internal enum Home {
    /// Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos.
    internal static let description = Strings.tr("Localizable", "home.description", fallback: "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos.")
    /// Já sou cliente
    internal static let signIn = Strings.tr("Localizable", "home.signIn", fallback: "Já sou cliente")
    /// Quero fazer parte!
    internal static let signUp = Strings.tr("Localizable", "home.signUp", fallback: "Quero fazer parte!")
    /// Conta Digital PJ
    /// Poderosamente simples
    internal static let title = Strings.tr("Localizable", "home.title", fallback: "Conta Digital PJ\nPoderosamente simples")
  }
  internal enum Password {
    /// Esqueci minha senha
    internal static let forgotPassword = Strings.tr("Localizable", "password.forgotPassword", fallback: "Esqueci minha senha")
    /// Próximo
    internal static let nextStep = Strings.tr("Localizable", "password.nextStep", fallback: "Próximo")
    /// Digite sua senha de acesso
    internal static let solicitation = Strings.tr("Localizable", "password.solicitation", fallback: "Digite sua senha de acesso")
    /// Login Cora
    internal static let title = Strings.tr("Localizable", "password.title", fallback: "Login Cora")
  }
  internal enum SignIn {
    /// Qual seu CPF?
    internal static let cpfSolicitation = Strings.tr("Localizable", "signIn.cpfSolicitation", fallback: "Qual seu CPF?")
    /// Próximo
    internal static let nextStep = Strings.tr("Localizable", "signIn.nextStep", fallback: "Próximo")
    /// Login Cora
    internal static let title = Strings.tr("Localizable", "signIn.title", fallback: "Login Cora")
    /// Bem-vindo de volta!
    internal static let welcome = Strings.tr("Localizable", "signIn.welcome", fallback: "Bem-vindo de volta!")
  }
  internal enum TransactionDescription {
    /// Depósito via boleto
    internal static let billetDeposit = Strings.tr("Localizable", "transactionDescription.billetDeposit", fallback: "Depósito via boleto")
    /// Boleto Pago
    internal static let billetPaid = Strings.tr("Localizable", "transactionDescription.billetPaid", fallback: "Boleto Pago")
    /// Pagamento recebido
    internal static let paymentReceived = Strings.tr("Localizable", "transactionDescription.paymentReceived", fallback: "Pagamento recebido")
    /// Pagamento estornado
    internal static let paymentReversed = Strings.tr("Localizable", "transactionDescription.paymentReversed", fallback: "Pagamento estornado")
    /// Transfêrencia recebida
    internal static let transferReceived = Strings.tr("Localizable", "transactionDescription.transferReceived", fallback: "Transfêrencia recebida")
    /// Transfêrencia estornada
    internal static let trasferReversed = Strings.tr("Localizable", "transactionDescription.trasferReversed", fallback: "Transfêrencia estornada")
    /// Transfêrencia agendada
    internal static let trasferScheduled = Strings.tr("Localizable", "transactionDescription.trasferScheduled", fallback: "Transfêrencia agendada")
    /// Transfêrencia enviada
    internal static let trasferSent = Strings.tr("Localizable", "transactionDescription.trasferSent", fallback: "Transfêrencia enviada")
  }
  internal enum TransactionDetail {
    /// Agência %@ - Conta %@
    internal static func bankInfo(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "transactionDetail.bankInfo", String(describing: p1), String(describing: p2), fallback: "Agência %@ - Conta %@")
    }
    /// Cancelar agedamento
    internal static let cancelTransferSchedule = Strings.tr("Localizable", "transactionDetail.cancelTransferSchedule", fallback: "Cancelar agedamento")
    /// CPF %@
    internal static func cpf(_ p1: Any) -> String {
      return Strings.tr("Localizable", "transactionDetail.cpf", String(describing: p1), fallback: "CPF %@")
    }
    /// Developed by the Intel Corporation, HDCP stands for high-bandwidth digital content protection. As the descriptive name implies.
    internal static let description = Strings.tr("Localizable", "transactionDetail.description", fallback: "Developed by the Intel Corporation, HDCP stands for high-bandwidth digital content protection. As the descriptive name implies.")
    /// Descrição
    internal static let descriptionTitle = Strings.tr("Localizable", "transactionDetail.descriptionTitle", fallback: "Descrição")
    /// Data do pagamento
    internal static let paymentDate = Strings.tr("Localizable", "transactionDetail.paymentDate", fallback: "Data do pagamento")
    /// Para
    internal static let receiver = Strings.tr("Localizable", "transactionDetail.receiver", fallback: "Para")
    /// De
    internal static let sender = Strings.tr("Localizable", "transactionDetail.sender", fallback: "De")
    /// Compartilhar comprovante
    internal static let shareReceipt = Strings.tr("Localizable", "transactionDetail.shareReceipt", fallback: "Compartilhar comprovante")
    /// Detalhes da operação
    internal static let title = Strings.tr("Localizable", "transactionDetail.title", fallback: "Detalhes da operação")
    /// Data da transferência
    internal static let transferDate = Strings.tr("Localizable", "transactionDetail.transferDate", fallback: "Data da transferência")
    /// Valor
    internal static let value = Strings.tr("Localizable", "transactionDetail.value", fallback: "Valor")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
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
