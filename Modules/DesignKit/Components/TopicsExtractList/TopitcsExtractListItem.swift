//
//  TopitcsExtractListItem.swift
//  DesignKit
//
//  Created by Erik Santos on 16/03/24.
//

import SwiftUI

struct TopitcsExtractListItem: View {
    
    @Binding var selectedTabIndex: Int
    @State var index: Int
    var title: String
    
    let font: UIFont
    let selectedColor: UIColor
    let defaultColor: UIColor
    
    var body: some View {
        Button(action: {
            self.selectedTabIndex = index
        }) {
            Text(title)
                .font(Font(font))
                .padding(10)
                .foregroundColor(index == self.selectedTabIndex ? Color(selectedColor):  Color(defaultColor))
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .padding(.top, 30)
                        .foregroundColor(index == self.selectedTabIndex ? Color(selectedColor):  .clear)
                )
        }
    }
    
    init(selectedTabIndex: Binding<Int>, index: Int, title: String, font: UIFont, selectedColor: UIColor, defaultColor: UIColor) {
        self._selectedTabIndex = selectedTabIndex
        self.index = index
        self.title = title
        self.font = font
        self.selectedColor = selectedColor
        self.defaultColor = defaultColor
    }
}


#Preview {
    TopitcsExtractListItem(
        selectedTabIndex: .constant(.zero),
        index: .zero,
        title: "Teste",
        font: .boldSystemFont(ofSize: 14),
        selectedColor: .red,
        defaultColor: .black
    )
}
