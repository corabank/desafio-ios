import Foundation

struct TransactionSummarySceneModel {
    private(set) var total: String
    private(set) var sum: String
}

extension TransactionSummarySceneModel {
    init(mapping models: [TransactionModel]) {
        self.total = "\(models.count)"
        let sum = models.map { $0.value }.total
        self.sum = CachedNumberFormatter.shared.currencyFormat().string(from: NSNumber(value: sum)) ?? "R$ 0,00"
    }
}
