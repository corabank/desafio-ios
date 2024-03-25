//
//  LayoutHelper.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation
import UIKit

public final class LayoutHelper {
    
    public static let shared = LayoutHelper()
    
    private init() {}
    
    public func makeLabel(
        text: String,
        alignment: NSTextAlignment,
        numberOfLines: Int,
        font: UIFont?,
        textColor: UIColor?
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.font = font
        label.textColor = textColor
        return label
    }
    
    public func makeBold(_ label: UILabel, textBold: String, fontBold: UIFont?) -> UILabel {
        let attributedText = NSMutableAttributedString(string: label.text ?? "")
        let range = (attributedText.string as NSString).range(of: textBold)
        attributedText.addAttribute(.font, value: fontBold ?? UIFont.boldSystemFont(ofSize: label.font.pointSize), range: range)
        label.attributedText = attributedText
        return label
    }
    
    public func adjustLineHeight(_ label: UILabel, height: CGFloat) -> UILabel {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = height / label.font.lineHeight
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: label.font ?? .systemFont(ofSize: 14),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedText = NSAttributedString(string: label.text ?? String(), attributes: attributes)
        label.attributedText = attributedText
        
        return label
    }
    
    public func makeStackView(aligment: UIStackView.Alignment, spacing: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = aligment
        stack.spacing = spacing
        stack.axis = axis
        return stack
    }
    
    public func getSafeTopAreaHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
            return (windows.first?.safeAreaInsets.top ?? .zero) + 40
        }
        
        return .zero
    }
}
