import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    private let highlightedColor = UIColor(red: 0.81, green: 0.12, blue: 0.22, alpha: 1.00)
    private let normalColor = UIColor(red: 0.90, green: 0.30, blue: 0.43, alpha: 1.00)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color(highlightedColor): Color(normalColor))
            .cornerRadius(8)
            .opacity(isEnabled ? 1: 0.6)
    }
}




