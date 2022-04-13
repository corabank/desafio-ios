import Foundation

protocol ExtractServicing {
    func loadData() -> [StatementData]
}

final class ExtractService {
    @Published var userData = [StatementData]()
}

// MARK: - ExtractServicing
extension ExtractService: ExtractServicing {
    func loadData() -> [StatementData] {
        if let fileLocation = Bundle.main.url(forResource: "extract", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataFromJson = try jsonDecoder.decode([StatementData].self, from: data)
                self.userData = dataFromJson
                return userData
            } catch {
                print(error)
            }
        }
        return []
    }
}
