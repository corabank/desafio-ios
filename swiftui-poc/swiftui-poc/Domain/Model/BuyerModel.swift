import Foundation

struct BuyerModel {
    private(set) var name: String
    private(set) var email: String
}

extension BuyerModel {
    
    init(mapping entity: BuyerEntity) {
        self.name = entity.name
        self.email = entity.email
    }
}
