//
//  BaseViewControllerProtocol.swift
//  CoraDesafio
//
//  Created by Erik Santos on 13/03/24.
//

import DesignKit

protocol BaseViewControllerProtocol {
    func setDefaultNavigation(title: String) -> StickNavigationViewModel
}

extension BaseViewControllerProtocol {
    func setDefaultNavigation(title: String = "") -> StickNavigationViewModel {
        return StickNavigationViewModel(
            title: StickNavigationTitle(text: title, font: .font(14), color: CoraAssets.darkGray.color),
            leftButton: StickNavigationLeftButton(image: .systemImage(CoraStrings.Icons.chevronLeft), color: CoraAssets.defaultPinkColor.color),
            backgroundColor: CoraAssets.lightGray.color
        )
    }
}
