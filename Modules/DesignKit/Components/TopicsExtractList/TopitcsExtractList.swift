//
//  TopitcsExtractList.swift
//  DesignKit
//
//  Created by Erik Santos on 16/03/24.
//

import SwiftUI
import UIKit
public struct TopitcsExtractList: View {
    
    let tabs: [String]// Seus botões
    @Binding var selectedTabIndex: Int
    
    let font: UIFont
    let selectedColor: UIColor
    let defaultColor: UIColor
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<tabs.count) { index in
                    TopitcsExtractListItem(
                        selectedTabIndex: $selectedTabIndex,
                        index: index,
                        title: tabs[index],
                        font: font,
                        selectedColor: selectedColor,
                        defaultColor: defaultColor
                    )
                }
            }
            .padding()
        }
    }
    
    public init(tabs: [String], selectedTabIndex: Binding<Int>, font: UIFont?, selectedColor: UIColor, defaultColor: UIColor) {
        self.tabs = tabs
        self._selectedTabIndex = selectedTabIndex
        self.font = font ?? .boldSystemFont(ofSize: 14)
        self.selectedColor = selectedColor
        self.defaultColor = defaultColor
    }
}

#Preview {
    TopitcsExtractList(
        tabs: ["Tudo", "Entrada", "Saida", "Futuro"],
        selectedTabIndex: .constant(1),
        font: .boldSystemFont(ofSize: 14),
        selectedColor: .red,
        defaultColor: .black
    )
}

extension TopitcsExtractList {
    
}
