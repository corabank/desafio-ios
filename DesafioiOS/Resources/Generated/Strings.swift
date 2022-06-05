// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {

  internal enum Alert {
    internal enum ActionOK {
      /// OK
      internal static let title = Localization.tr("Localizable", "Alert.actionOK.title")
    }
    internal enum Authorized {
      /// Sua foto foi salva na galeria
      internal static let message = Localization.tr("Localizable", "Alert.authorized.message")
      /// Sucesso!
      internal static let title = Localization.tr("Localizable", "Alert.authorized.title")
    }
    internal enum Denied {
      /// Verifique o acesso à biblioteca para este aplicativo em Configurações > Privacidade
      internal static let message = Localization.tr("Localizable", "Alert.denied.message")
      /// Acesso Negado!!
      internal static let title = Localization.tr("Localizable", "Alert.denied.title")
    }
    internal enum Limited {
      /// Libere espaço do seu armazenamento e tente novamente
      internal static let message = Localization.tr("Localizable", "Alert.limited.message")
      /// Memória cheia!
      internal static let title = Localization.tr("Localizable", "Alert.limited.title")
    }
  }

  internal enum Extract {
    /// Extrato
    internal static let navigationTitle = Localization.tr("Localizable", "Extract.navigationTitle")
  }

  internal enum Intro {
    /// Já sou cliente
    internal static let buttonLogin = Localization.tr("Localizable", "Intro.buttonLogin")
    /// Quero fazer parte!
    internal static let buttonRegister = Localization.tr("Localizable", "Intro.buttonRegister")
    /// Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos.
    internal static let descriptionLabel = Localization.tr("Localizable", "Intro.descriptionLabel")
    /// Conta Digital PJ
    /// Poderosamente simples
    internal static let titleLabel = Localization.tr("Localizable", "Intro.titleLabel")
  }

  internal enum Login {
    /// Próximo
    internal static let buttonNext = Localization.tr("Localizable", "Login.buttonNext")
    /// Login Cora
    internal static let titleNavigation = Localization.tr("Localizable", "Login.titleNavigation")
    internal enum CpfForm {
      /// ccc.ccc.ccc-cc
      internal static let mask = Localization.tr("Localizable", "Login.cpfForm.mask")
      /// 000.000.000-00
      internal static let placeholder = Localization.tr("Localizable", "Login.cpfForm.placeholder")
      /// Bem-vindo de volta!
      internal static let title = Localization.tr("Localizable", "Login.cpfForm.title")
      /// Qual seu CPF?
      internal static let titleTextField = Localization.tr("Localizable", "Login.cpfForm.titleTextField")
    }
    internal enum PasswordForm {
      /// Esqueci minha senha
      internal static let buttontitle = Localization.tr("Localizable", "Login.passwordForm.buttontitle")
      /// Senha
      internal static let placeholder = Localization.tr("Localizable", "Login.passwordForm.placeholder")
      /// Digite sua senha de acesso
      internal static let titleTextField = Localization.tr("Localizable", "Login.passwordForm.titleTextField")
    }
  }

  internal enum Receipt {
    /// Detalhes do agendamento
    internal static let navigationTitle = Localization.tr("Localizable", "Receipt.navigationTitle")
  }

  internal enum ReceiptButtonsCell {
    /// Cancelar agendamento
    internal static let cancelScheduling = Localization.tr("Localizable", "ReceiptButtonsCell.cancelScheduling")
    /// Compartilhar comprovante
    internal static let shareReceipt = Localization.tr("Localizable", "ReceiptButtonsCell.shareReceipt")
  }

  internal enum ReceiptDescriptionCell {
    /// Descrição
    internal static let title = Localization.tr("Localizable", "ReceiptDescriptionCell.title")
  }

  internal enum ReceiptInfoCell {
    /// Data da tranferência
    internal static let dateTitle = Localization.tr("Localizable", "ReceiptInfoCell.dateTitle")
    /// Valor
    internal static let valueTitle = Localization.tr("Localizable", "ReceiptInfoCell.valueTitle")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
