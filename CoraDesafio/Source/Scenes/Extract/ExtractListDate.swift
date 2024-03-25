//
//  ExtractList.swift
//  DesignKit
//
//  Created by Erik Santos on 17/03/24.
//

import SwiftUI
import UIKit
import CoreKit
import DesignKit
import NetwokKit

struct ExtractListDate: View {

    @Binding var extractList: ExtractResponse?
    
    var fontTitle: UIFont
    var colorTitle: UIColor
    var backgroundColorTitle: UIColor
    var extractListModel: ExtractDetailsModel
    var stickModel: StickNavigationLinkItems
    var service: CoraServicing
    
    var body: some View {
        ForEach(extractList?.results ?? ExtractResponse.Mock.value.results, id: \.date) { value in
           makeContentItem(value)
        }
        .background(Color.white)
    }
    
    init(extractList: Binding<ExtractResponse?>, fontTitle: UIFont, colorTitle: UIColor, backgroundColorTitle: UIColor, extractListModel: ExtractDetailsModel, stickModel: StickNavigationLinkItems, service: CoraServicing) {
        self._extractList = extractList
        self.fontTitle = fontTitle
        self.colorTitle = colorTitle
        self.backgroundColorTitle = backgroundColorTitle
        self.extractListModel = extractListModel
        self.stickModel = stickModel
        self.service = service
    }
}

extension ExtractListDate {
    private func makeContentItem(_ value: ExtractResultResponse) -> some View {
        VStack {
            HStack {
                Text(ConvertionAdapterHelper.shared.converToDateDetails(value.date, formatter: .yyyMMdd))
                    .font(Font(fontTitle))
                    .foregroundStyle(Color(colorTitle))
                    .padding()
                Spacer()
            }
            .frame(height: 32)
            .background(Color(backgroundColorTitle).ignoresSafeArea())
            
            ExtractDetailsList(extractDetailsList: value.items, modelFont: extractListModel, stickModel: stickModel, service: service)
                .padding(.horizontal, 30)
        }
    }
}

#Preview {
    NavigationStack {
        ExtractListDate(extractList: .constant(ExtractResponse.Mock.value), fontTitle: .systemFont(ofSize: 16), colorTitle: .darkGray, backgroundColorTitle: .lightGray, extractListModel: ExtractDetailsModel(fontCurrentTitle: .systemFont(ofSize: 16), fontTitle: .boldSystemFont(ofSize: 16), fontDescription: .systemFont(ofSize: 14), fontTime: .systemFont(ofSize: 12), defaultColor: .gray, activeColor: .blue), stickModel: StickNavigationLinkItems(title: AccessibleTitleNavigationSwiftUI(text: "Teste", textColor: .red, backgroundColor: .red), font: .boldSystemFont(ofSize: 16), buttonColor: .red), service: CoraService())
    }

}
