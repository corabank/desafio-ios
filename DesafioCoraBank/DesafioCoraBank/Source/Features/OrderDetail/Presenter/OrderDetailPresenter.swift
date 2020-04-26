//
//  OrderDetailPresenter.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class OrderDetailPresenter: DKPresenter {
    fileprivate var view: OrderDetailViewControllerProtocol? { return self.getAbstractView() as? OrderDetailViewControllerProtocol }
    
    private func formatDate(_ dateToFormat: Date?) -> String {
        guard let date = dateToFormat else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}

extension OrderDetailPresenter: OrderDetailPresenterProtocol {
    func processOrder(entity: OrderEntity?) {
        guard let orderEntity = entity else {
            self.view?.alertErrorLoadingData()
            return
        }
        
        let valueViewModel = OrderValueViewModel(orderEntity, showPaymentMethod: true)
        sync { self.view?.addValueCell(viewModel: valueViewModel) }
        
        let buyerViewModel = OrderDetailIconInfoViewModel(iconImageName: "icon-login", fieldText: "order_buyer".localized, valueText: orderEntity.buyerName ?? "", valueColor: .cbBlack)
        sync { self.view?.addIconInfoCell(viewModel: buyerViewModel) }
        
        let emailViewModel = OrderDetailIconInfoViewModel(iconImageName: "icon-email", fieldText: "order_email".localized, valueText: orderEntity.email ?? "", valueColor: .cbBlack)
        sync { self.view?.addIconInfoCell(viewModel: emailViewModel) }
        
        let dateViewModel = OrderDetailIconInfoViewModel(iconImageName: "icon-calendar", fieldText: "order_created_at".localized, valueText: formatDate(orderEntity.date), valueColor: .cbBlack)
        sync { self.view?.addIconInfoCell(viewModel: dateViewModel) }
        
        let statusViewModel = OrderDetailIconInfoViewModel(iconImageName: "icon-watch", fieldText: "order_status".localized, valueText: orderEntity.status?.rawValue.localized ?? "", valueColor: orderEntity.status?.statusColor ?? .cbWhite)
        sync { self.view?.addIconInfoCell(viewModel: statusViewModel) }
        
        let sectionHeaderViewModel = OrderDetailSectionHeaderViewModel(sectionTitle: "order_financial_summary".localized)
        sync { self.view?.addSectionHeaderCell(viewModel: sectionHeaderViewModel) }
        
        let totalValueTextInfoViewModel = OrderDetailTextInfoViewModel(size: .regular, fieldText: "order_total_value".localized, currency: "R$", valueText: String(format: "%.02f", (orderEntity.value ?? 0)), fontColor: .cbBlack)
        sync { self.view?.addTextInfoCell(viewModel: totalValueTextInfoViewModel) }
        
        let taxesTextInfoViewModel = OrderDetailTextInfoViewModel(size: .regular, fieldText: "order_taxes".localized, currency: "R$", valueText: String(format: "%.02f", (orderEntity.taxes ?? 0)), fontColor: .cbRed)
        sync { self.view?.addTextInfoCell(viewModel: taxesTextInfoViewModel) }
        
        let receipt = (orderEntity.value ?? 0) - (orderEntity.taxes ?? 0)
        let receiptTextInfoViewModel = OrderDetailTextInfoViewModel(size: .big, fieldText: "order_my_receipt".localized, currency: "R$", valueText: String(format: "%.02f", receipt), fontColor: .cbLightBlue)
        sync { self.view?.addTextInfoCell(viewModel: receiptTextInfoViewModel) }
        
        let sandboxViewModel = OrderDetailSandboxViewModel(sandbox: "\("order_sandbox".localized): \(orderEntity.sandbox ?? "")")
        sync { self.view?.addSandboxCell(viewModel: sandboxViewModel) }
        
        sync { self.view?.showLoading(false) }
    }
}
