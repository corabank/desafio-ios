//
//  SwiftUIView.swift
//  CoraDesafio
//
//  Created by Erik Santos on 23/03/24.
//

import SwiftUI
import CoreKit
import DesignKit
import NetwokKit

struct ExtractDetailsView: View {
    
    @EnvironmentObject
    var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    
                    switch viewModel.status {
                    case .loading:
                        makeShimmer()
                    case .error:
                        /* Intentionaly Implemented */
                        Text("Error")
                    case .success:
                        if let detailsModel = viewModel.extractDetails {
                            makeSuccessContent(detailsModel)
                        }
                    }
                    
                }
                .padding(.top, 20)
                .padding(.horizontal, 16)
            }
            
            Spacer()
            
            if viewModel.status == .success {
                makeButton()
                    .padding(.horizontal, 16)
            }
        }
        .task {
            await viewModel.fetchExtractDetails()
        }
    }
}

extension ExtractDetailsView {
    
    private func makeButton() -> some View {
        CoraButtonSwiftUI(
            text: CoraStrings.ExtractDetailsView.Button.title,
            font: .font(16, isBold: true),
            background: CoraAssets.defaultPinkColor.color,
            tintColor: .white,
            image: CoraStrings.Icons.shareUp,
            imageColor: CoraAssets.darkGray.color) {
                /* Intentionaly Implemented */
            }
    }
    
    private func makeSuccessContent(_ value: ExtractDetailsResponse) -> some View {
        Group {
            HStack(alignment: .center) {
                Image(systemName: CoraStrings.Icons.signOut)
                    .resizable()
                    .frame(width: 24, height:24)
                    .tint(.black)
                
                Text(value.label)
                    .font(Font(UIFont.font(16, isBold: true)))
                    .foregroundStyle(Color(CoraAssets.lightBlack.color))
            }
            
            makeValor(value)
            makeDate(value)
            makeOrige(value)
            makeDestination(value)
            makeDescription(value)
        }
           
    }
    
    private func makeValor(_ value: ExtractDetailsResponse) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(CoraStrings.Commons.valor)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.lightBlack.color))
            
            HStack(spacing: 5) {
                Text(CoraStrings.Commons.concurrency)
                    .font(Font(UIFont.font(16)))
                    .foregroundStyle(Color(CoraAssets.lightBlack.color))
                
                Text(ConvertionAdapterHelper.shared.convertToCurrency(value.amount))
                    .font(Font(UIFont.font(16, isBold: true)))
                    .foregroundStyle(Color(CoraAssets.lightBlack.color))
            }
        }
    }
    
    private func makeDate(_ value: ExtractDetailsResponse) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(CoraStrings.Commons.date)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.lightBlack.color))
            
            Text(ConvertionAdapterHelper.shared.converToDateDetails(value.dateEvent, formatter: .yyyMMDDTHHmmssZ))
                .font(Font(UIFont.font(16, isBold: true)))
                .foregroundStyle(Color(CoraAssets.lightBlack.color))
        }
    }
    
    private func makeOrige(_ value: ExtractDetailsResponse) -> some View {
        VStack(alignment: .leading) {
            Text(CoraStrings.Commons.of)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.lightBlack.color))
            Spacer(minLength: 5)
            Text(value.sender.name)
                .font(Font(UIFont.font(16, isBold: true)))
                .foregroundStyle(Color(CoraAssets.lightBlack.color))
            Spacer(minLength: 5)
            
            HStack(spacing: 5) {
                Text(value.sender.documentType.uppercased())
                    .font(Font(UIFont.font(14)))
                    .foregroundStyle(Color(CoraAssets.darkGray.color))
                
                Text(ConvertionAdapterHelper.shared.formatCPFOrCNPJ(value.sender.documentNumber, type: value.sender.documentType.uppercased()))
                    .font(Font(UIFont.font(14)))
                    .foregroundStyle(Color(CoraAssets.darkGray.color))
            }
     
            Text(value.sender.bankName)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.darkGray.color))
            Text(value.sender.bankNumber)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.darkGray.color))
        }
    }
    
    private func makeDestination(_ value: ExtractDetailsResponse) -> some View {
        VStack(alignment: .leading)  {
            Text(CoraStrings.Commons.for)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.lightBlack.color))
            Spacer(minLength: 5)
            Text(value.recipient.name)
                .font(Font(UIFont.font(16, isBold: true)))
                .foregroundStyle(Color(CoraAssets.lightBlack.color))
            Spacer(minLength: 5)
            
            HStack(spacing: 5) {
                Text(value.recipient.documentType.uppercased())
                    .font(Font(UIFont.font(14)))
                    .foregroundStyle(Color(CoraAssets.darkGray.color))
                
                Text(ConvertionAdapterHelper.shared.formatCPFOrCNPJ(value.recipient.documentNumber, type: value.recipient.documentType.uppercased()))
                    .font(Font(UIFont.font(14)))
                    .foregroundStyle(Color(CoraAssets.darkGray.color))
            }
     
            Text(value.recipient.bankName)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.darkGray.color))
            
            Text(value.recipient.bankNumber)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.darkGray.color))
            
        }
    }
    
    private func makeDescription(_ value: ExtractDetailsResponse) -> some View {
        VStack(alignment: .leading, spacing: 5)  {
            Text(CoraStrings.ExtractDetailsView.description)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.lightBlack.color))
            
            Text(value.description)
                .font(Font(UIFont.font(14)))
                .foregroundStyle(Color(CoraAssets.darkGray.color))
                .multilineTextAlignment(.leading)
                .lineSpacing(5)
        }
    }
    
    private func makeShimmer() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            CoraShimmer()
                .frame(height: 32)
                .padding(.bottom)
            
            makeListShimmer()
        }
    }
    
    private func makeListShimmer() -> some View {
        ForEach(0..<5) {_ in
            CoraShimmer()
                .frame(width: 238, height: 38)
            CoraShimmer()
                .frame(width: 165, height: 16)
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    ExtractDetailsView()
        .environmentObject(ExtractDetailsViewModel(extractDetails: ExtractResponse.Mock.extractDetails,service: CoraService(), extractId: "123-456-789"))
}
