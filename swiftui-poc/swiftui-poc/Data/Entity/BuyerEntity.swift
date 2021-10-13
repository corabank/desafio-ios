import Foundation

struct BuyerEntity {
    private(set) var name: String
    private(set) var email: String
}

extension BuyerEntity: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
    }
}
