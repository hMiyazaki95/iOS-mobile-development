import Foundation

struct MuniService {
    
    func fetchLines(_ callback: @escaping ([LineElement]) -> Void) {
        let urlString = "https://api.511.org/transit/lines?api_key=\(Constants.apiKey)&operator_id=SF&Format=json"
        
        guard let url = URL(string: urlString) else {
            print("Invalid url")
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (maybeData: Data?, maybeResponse: URLResponse?, maybeError: Error?) -> Void in
            // We should also check the response and the error but we will skip that for now
            guard let data = maybeData else {
                print("Server didn't return data") // TODO: notify the user
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let rawLineElements = try decoder.decode([RawLineElement].self, from: data)
                let lineElements = rawLineElements.map({ LineElement(rawLineElement: $0) })
                print(lineElements)
                callback(lineElements)
            } catch {
                print(error)
            }
            
        })
        task.resume()
        // returning from fetchLines
    }
}
