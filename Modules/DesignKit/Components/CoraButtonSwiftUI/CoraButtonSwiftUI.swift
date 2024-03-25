//
//  CoraButtonSwiftUI.swift
//  DesignKit
//
//  Created by Erik Santos on 23/03/24.
//

import SwiftUI
import UIKit

public struct CoraButtonSwiftUI: View {
    
    var action: () -> Void
    let text: String
    let font: UIFont
    let background: UIColor
    let tintColor: UIColor
    let image: String
    let imageColor: UIColor
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(text)
                    .frame(maxHeight: 40)
                Spacer()
                
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color(imageColor))
            }
            
        }
        .buttonStyle(GrowingButton(font: font, background: background, tintColor: tintColor))
    }
    
    public init(text: String, font: UIFont?, background: UIColor, tintColor: UIColor, image: String, imageColor: UIColor, action: @escaping () -> Void) {
        self.text = text
        self.font = font ?? .systemFont(ofSize: 14)
        self.background = background
        self.tintColor = tintColor
        self.image = image
        self.imageColor = imageColor
        self.action = action
    }
}


struct GrowingButton: ButtonStyle {
    
    let font: UIFont
    let background: UIColor
    let tintColor: UIColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(background))
            .foregroundStyle(Color(tintColor))
            .font(Font(font))
            .cornerRadius(18)
            .overlay {
                RoundedRectangle(
                    cornerRadius: 18,
                    style: .continuous
                )
                .stroke(Color(background), lineWidth: 3)
                
                
            }
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
    init(font: UIFont, background: UIColor, tintColor: UIColor) {
        self.font = font
        self.background = background
        self.tintColor = tintColor
    }
}


#Preview {
    CoraButtonSwiftUI(text: "Compartilhar comprovante", font: .boldSystemFont(ofSize: 15), background: .red, tintColor: .white, image: "square.and.arrow.up", imageColor: .black) {
        print("Clicou")
    }
        .padding()
}
