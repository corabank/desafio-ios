import Foundation

struct BuyerSceneModel {
    private(set) var name: String
    private(set) var email: String
}

extension BuyerSceneModel {
    init(mapping model: BuyerModel) {
        self.name = model.name
        self.email = model.email
    }
}
