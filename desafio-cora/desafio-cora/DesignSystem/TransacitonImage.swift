//
//  TransacitonImage.swift
//  desafio-cora
//
//  Created by Matheus Perez on 14/04/22.
//

import UIKit

enum TransacionImage {
    case image(transaction: TransactionDetail)
    
    func getImage() -> UIImage? {
        switch self {
        case .image(let transaction):
            var image: UIImage?
            switch transaction.transactionStatus.transactionType {
            case .transfer:
                if transaction.transactionStatus.status == .complete,
                   transaction.transactionStatus.transactionEntry == .input {
                    image = Images.downArrow
                } else if transaction.transactionStatus.status == .complete,
                          transaction.transactionStatus.transactionEntry == .output {
                    image = Images.upArrow
                } else if transaction.transactionStatus.status == .reversed {
                    image = Images.returnArrow
                } else {
                    image = Images.timeClock
                }
            case .payment:
                if transaction.transactionStatus.status == .complete,
                   transaction.transactionStatus.transactionEntry == .input {
                    image = Images.downArrow
                } else if transaction.transactionStatus.status == .reversed,
                          transaction.transactionStatus.transactionEntry == .output {
                    image = Images.returnArrow
                }
            case .ticket:
                image = Images.barCode
            }
            return image
        }
    }
}
