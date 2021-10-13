import Foundation

struct TransactionRequest: Request { }

struct TransactionResponse: Response {
    private(set) var transactions: [TransactionEntity]
}

extension TransactionResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case transactions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.transactions = try container.decode([TransactionEntity].self, forKey: .transactions)
    }
}
