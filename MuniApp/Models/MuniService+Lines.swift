
import Foundation

extension MuniService {
    func fetchLines(callback: @escaping (Result<[LineElement], ServiceError>) -> Void) {
        let urlString = "https://api.511.org/transit/lines?api_key=\(Constants.apiKey)&operator_id=SF&Format=json"
        
        guard let url = URL(string: urlString) else {
            callback(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (maybeData: Data?, maybeResponse: URLResponse?, maybeError: Error?) -> Void in
            // We should also check the response and the error but we will skip that for now
            guard let data = maybeData else {
                callback(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let rawLineElements = try decoder.decode([RawLineElement].self, from: data)
                let lineElements = rawLineElements.map({ LineElement(rawLineElement: $0) })
                callback(.success(lineElements))
            } catch {
                callback(.failure(.decodingError))
            }
            
        })
        task.resume()
        // returning from fetchLines
    }
}
