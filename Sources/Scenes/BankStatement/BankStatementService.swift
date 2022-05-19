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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let decodedData = try decoder.decode(BankStatement.self, from: data)
            return decodedData.dailyTransations
        } catch {
            print("error: \(error)")
            return []
        }
    }
}
