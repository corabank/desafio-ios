import Foundation

protocol TransactionDetailServicing {
    func getTransactionDetailData(id: Int) -> TransactionDetail?
}

final class TransactionDetailService: TransactionDetailServicing {
    func getTransactionDetailData(id: Int) -> TransactionDetail? {
        let filePath = "transaction-detail-\(id)"
        guard let url = Bundle.main.url(forResource: filePath, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(DateFormatter.decoderDateFormatter)
            let decodedData = try decoder.decode(TransactionDetail.self, from: data)
            return decodedData
        } catch {
            print("error: \(error)")
            return nil
        }
    }
}
