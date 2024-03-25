//
//  ExtractDetailsList.swift
//  DesignKit
//
//  Created by Erik Santos on 17/03/24.
//

import SwiftUI
import CoreKit
import DesignKit
import NetwokKit

typealias ExtractDetailsModel = ExtractDetailsList.Model

struct ExtractDetailsList: View {

    private var extractDetailsList: [ExtractItemResponse]
    private var modelFont: ExtractDetailsModel
    private var stickModel: StickNavigationLinkItems
    private var service: CoraServicing
    
    var body: some View {
        
        VStack(spacing: 1) {
            ForEach(extractDetailsList, id: \.id) { value in
                StickNavigationLink(
                    destination: ExtractDetailsView()
                        .environmentObject(
                            ExtractDetailsViewModel(service: service, extractId: value.id)
                        ),
                    label: {
                        makeContent(value)
                    }, stickModel: stickModel
                )
            }
        }
    }
    
    init(extractDetailsList: [ExtractItemResponse], modelFont: ExtractDetailsModel, stickModel: StickNavigationLinkItems, service: CoraServicing) {
        self.extractDetailsList = extractDetailsList
        self.modelFont = modelFont
        self.stickModel = stickModel
        self.service = service
    }
}

extension ExtractDetailsList {
    private func makeContent(_ value: ExtractItemResponse) -> some View {
        HStack(spacing: 20) {
            VStack(alignment: .center) {
                Image(systemName: CoraStrings.Icons.signOut)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .tint(.black)
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 5) {
                        Text(CoraStrings.Commons.concurrency)
                            .font(Font(modelFont.fontDescription))
                            .foregroundStyle(Color(modelFont.activeColor))
                        
                        Text(ConvertionAdapterHelper.shared.convertToCurrency(value.amount))
                            .font(Font(modelFont.fontTitle))
                            .foregroundStyle(Color(modelFont.activeColor))
                            .bold()
                    }
                    
                    Text(value.label)
                        .font(Font(modelFont.fontDescription))
                        .foregroundStyle(Color(modelFont.activeColor))
                    
                    Text(value.name)
                        .font(Font(modelFont.fontDescription))
                        .foregroundStyle(Color(modelFont.defaultColor))
                }
                Spacer()
            }
            
            
            VStack(alignment: .center) {
                Text(ConvertionAdapterHelper.shared.extractTimeWithoutSeconds(from: value.dateEvent))
                    .font(Font(modelFont.fontDescription))
                    .foregroundStyle(Color(modelFont.defaultColor))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 64)
        .padding(.vertical, 15)
    }
}

#Preview {
    ExtractDetailsList(
        extractDetailsList: ExtractResponse.Mock.extractItems,
        modelFont: ExtractDetailsModel(fontCurrentTitle: nil, fontTitle: nil, fontDescription: nil, fontTime: nil, defaultColor: .red, activeColor: .black),
        stickModel: StickNavigationLinkItems(title: .init(text: "Teste", textColor: .red, backgroundColor: .red), font: nil, buttonColor: .red),
        service: CoraService()
    )
        .padding()
}

extension ExtractDetailsList {
    public struct Model {
        let fontCurrentTitle: UIFont
        let fontTitle: UIFont
        let fontDescription: UIFont
        let fontTime: UIFont
        let defaultColor: UIColor
        let activeColor: UIColor
        
        public init(fontCurrentTitle: UIFont?, fontTitle: UIFont?, fontDescription: UIFont?, fontTime: UIFont?, defaultColor: UIColor, activeColor: UIColor) {
            self.fontCurrentTitle = fontCurrentTitle ?? .systemFont(ofSize: 16)
            self.fontTitle = fontTitle ?? .systemFont(ofSize: 16)
            self.fontDescription = fontDescription ?? .systemFont(ofSize: 14)
            self.fontTime = fontTime ?? .systemFont(ofSize: 12)
            self.defaultColor = defaultColor
            self.activeColor = activeColor
        }
    }
}
