import Foundation

protocol BankStatementServicing {
    func getBankStatementData() -> [DailyTransactions]
}

final class BankStatementService: BankStatementServicing {
    func getBankStatementData() -> [DailyTransactions] {
        let filePath = "bank-statement-data"
        guard let url = Bundle.main.url(forResource: filePath, withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(DateFormatter.decoderDateFormatter)
            let decodedData = try decoder.decode([DailyTransactions].self, from: data)
            return decodedData
        } catch {
            print("error: \(error)")
            return []
        }
    }
}
