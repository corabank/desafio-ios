//
//  ExtractListView.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import SwiftUI
import DesignKit
import UIKit
import NetwokKit

struct ExtractListView: View {
    
    @ObservedObject
    var viewModel: ViewModel
    
    var body: some View {
        CoreNavigationSwiftUI(
            rightButton: AccessibleButtonNavigationSwiftUI(Image: CoraAssets.signOut.image, action: viewModel.signOut),
            title: AccessibleTitleNavigationSwiftUI(text: CoraStrings.ExtractListView.navigationTitle, textColor: CoraAssets.lightBlack.color, backgroundColor: CoraAssets.lightGray.color),
            font: .font(14),
            buttonColor: CoraAssets.defaultPinkColor.color) {
                VStack {
                    makeExtractTopicScreen()
                    makeExtractScreen()
                    Spacer()
                }
                
            }
            .task {
                await viewModel.fetchExtractList()
                await viewModel.updateToken()
            }
    }
    
    init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

extension ExtractListView {
    
    private func makeExtractTopicScreen() -> some View {
        TopitcsExtractList(
            tabs: 
            [
                CoraStrings.ExtractListView.Button.all,
                CoraStrings.ExtractListView.Button.entrency,
                CoraStrings.ExtractListView.Button.exit,
                CoraStrings.ExtractListView.Button.future
            ],
            selectedTabIndex: $viewModel.selectedIndex,
            font: .font(14),
            selectedColor: CoraAssets.defaultPinkColor.color,
            defaultColor: CoraAssets.darkGray.color
        )
    }
    
    private func makeExtractScreen() -> some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    switch viewModel.status {
                    case .loading:
                        makeLoadingState()
                    case .error:
                        /* Intentionaly Implemented */
                        Text("Error")
                    case .success:
                        makeSuccessState()
                    }
                    Spacer()
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetchExtractList()
                }
            }
        }
    }
    
    private func makeSuccessState() -> some View {
        ExtractListDate(
            extractList: $viewModel.extractList,
            fontTitle: .font(12, isBold: true),
            colorTitle: CoraAssets.darkGray.color,
            backgroundColorTitle: CoraAssets.lightGray.color,
            extractListModel: ExtractDetailsModel(
                fontCurrentTitle: .font(16),
                fontTitle: .font(16, isBold: true),
                fontDescription: .font(14),
                fontTime: .font(12),
                defaultColor: CoraAssets.darkGray.color,
                activeColor: CoraAssets.lightBlue.color
            ), stickModel: StickNavigationLinkItems(
                leftButton: AccessibleButtonNavigationSwiftUI(Image: .systemImage(CoraStrings.Icons.chevronLeft), action:{        /* Intentionaly Implemented */ }) ,
                title: AccessibleTitleNavigationSwiftUI(text: CoraStrings.ExtractDetailsView.navigationTitle, textColor: CoraAssets.lightBlack.color, backgroundColor: CoraAssets.lightGray.color),
                font: .font(14), buttonColor: CoraAssets.defaultPinkColor.color
            ), service: viewModel.service
        )
    
    }
    
    private func makeLoadingState() -> some View {
        VStack(alignment: .leading) {
            
            ForEach(0..<2) {_ in
                CoraShimmer()
                    .frame(height: 32)
                    .padding(.bottom, 20)
                
                makeListItemShimmer()
                    .padding(.leading, 16)
            }
            
        }
    }
    
    private func makeListItemShimmer() -> some View {
        ForEach(0..<4) {_ in
            CoraShimmer()
                .frame(width: 238, height: 38)
            CoraShimmer()
                .frame(width: 165, height: 16)
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    ExtractListView(ExtractListViewModel(service: CoraService()))
}
