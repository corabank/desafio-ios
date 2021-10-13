import Foundation

struct TransactionEntity {
    private(set) var id: String
    private(set) var value: Float
    private(set) var date: String
    private(set) var status: String
    private(set) var paymentMethod: String
    private(set) var taxes: Float
    private(set) var buyer: BuyerEntity
}

extension TransactionEntity: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case value
        case date
        case status
        case paymentMethod
        case taxes
        case buyer
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.value = try container.decode(Float.self, forKey: .value)
        self.date = try container.decode(String.self, forKey: .date)
        self.status = try container.decode(String.self, forKey: .status)
        self.paymentMethod = try container.decode(String.self, forKey: .paymentMethod)
        self.taxes = try container.decode(Float.self, forKey: .taxes)
        self.buyer = try container.decode(BuyerEntity.self, forKey: .buyer)
    }
}
