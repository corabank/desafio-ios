//
//  StickNavigationSwiftUI.swift
//  DesignKit
//
//  Created by Erik Santos on 16/03/24.
//

import SwiftUI
import UIKit

public typealias AccessibleTitleNavigationSwiftUI = StickNavigationSwiftUI.AccessibleText
public typealias AccessibleButtonNavigationSwiftUI = StickNavigationSwiftUI.AccessibleButton

public struct StickNavigationSwiftUI: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var rightButton: AccessibleButtonNavigationSwiftUI?
    @State var leftButton: AccessibleButtonNavigationSwiftUI?
    
    let title: AccessibleText
    let font: UIFont?
    let buttonColor: UIColor
    
    public var body: some View {
        HStack {
            if let leftButton = leftButton {
                makeSideButton(leftButton)
            }
            Spacer()
            makeText()
            Spacer()
            
            if let rightButton = rightButton {
                makeSideButton(rightButton)
            }
            
        }
        .padding()
        .tint(Color(uiColor: buttonColor))
        .font(.headline)
        .background(
            Color(uiColor: title.backgroundColor).ignoresSafeArea(edges: .top)
        )
    }
}

#Preview {
    VStack {
        StickNavigationSwiftUI(
            rightButton: AccessibleButtonNavigationSwiftUI(Image: UIImage(systemName:"chevron.right"), action: {}),
            leftButton: AccessibleButtonNavigationSwiftUI(Image: UIImage(systemName:"chevron.right"), action: {}),
            title: AccessibleTitleNavigationSwiftUI(text: "Extrato", textColor: .white, backgroundColor: .gray),
            font: .boldSystemFont(ofSize: 18),
            buttonColor: .red
        )
        
        Spacer()
    }
}

extension StickNavigationSwiftUI {
    
    private func makeText() -> some View {
        Text(title.text)
            .font(Font(font ?? .boldSystemFont(ofSize: 14)))
            .fontWeight(.semibold)
            .foregroundStyle(Color(uiColor:title.textColor))
            .offset(x: rightButton != nil && leftButton != nil ? .zero : leftButton != nil ? -5 : rightButton != nil ? 10 : .zero
            )
    }
    
    private func makeSideButton(_ sideButton: AccessibleButtonNavigationSwiftUI) -> some View {
        Button {
            
            guard leftButton != nil else {
                sideButton.action()
                return
            }
            presentationMode.wrappedValue.dismiss()

        } label: {
            if let image = sideButton.Image {
                Image(uiImage: image)
            }
        }
    }
}

extension StickNavigationSwiftUI {
    public struct AccessibleText {
        let text: String
        let textColor: UIColor
        let backgroundColor: UIColor
        
        public init(text: String, textColor: UIColor, backgroundColor: UIColor) {
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
        }
    }
    
    public struct AccessibleButton {
        let Image: UIImage?
        let action: () -> Void
        
        public init(Image: UIImage?, action: @escaping () -> Void) {
            self.Image = Image
            self.action = action
        }
    }
}
