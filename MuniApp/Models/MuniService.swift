import Foundation

// http://api.511.org/transit/timetable?api_key=f5c4e5c7-f694-4c6a-adcb-5e7fa3c6ee34&operator_id=SF&line_id=N&Format=json
// MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))

struct MuniService {

    func fetchStops(_ completionHandler: @escaping (Result<[Stop], ServiceError>) -> Void) {
        let urlString = "http://api.511.org/transit/stops?api_key=f5c4e5c7-f694-4c6a-adcb-5e7fa3c6ee34&operator_id=SF&Format=json"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if let error = maybeError {
                completionHandler(.failure(.deviceError))
                return
            }
            guard let data = maybeData else {
                completionHandler(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(StopsResponse.self, from: data)
                let stops = response.Contents.dataObjects.ScheduledStopPoint
                    .compactMap(Stop.init)
                completionHandler(.success(stops))
                
                
//                let response: StopsResponse = try decoder.decode(StopsResponse.self, from: data)
//                let arrayOfRawTypes: [StopsResponse.Content.dataObjects.ScheduledStopPoint] = response.Contents.dataObjects.ScheduledStopPoint
//                let mapped: [Stop] = arrayOfRawTypes.compactMap(Stop.init)
//                completionHandler(.success(mapped))
            } catch {
                completionHandler(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    
    
    
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
    
    func fetchLines(successHandler: @escaping ([LineElement]) -> Void, failureHandler: @escaping (String) -> Void) {
        let urlString = "https://api.511.org/transit/lines?api_key=\(Constants.apiKey)&operator_id=SF&Format=json"
        
        guard let url = URL(string: urlString) else {
            failureHandler("Invalid url")
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (maybeData: Data?, maybeResponse: URLResponse?, maybeError: Error?) -> Void in
            if let error = maybeError {
                failureHandler("Error fetching")
                return
            }
            if let response: URLResponse = maybeResponse {
                
            }
            // We should also check the response and the error but we will skip that for now
            guard let data = maybeData else {
                failureHandler("Server didn't return data") // TODO: notify the user
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let rawLineElements = try decoder.decode([RawLineElement].self, from: data)
                let lineElements = rawLineElements.map({ LineElement(rawLineElement: $0) })
                successHandler(lineElements)
            } catch {
                failureHandler("Invalid JSON")
            }
        })
        task.resume()
        // returning from fetchLines
    }
    
    enum ServiceError: Error, CaseIterable {
        case invalidUrl
        case noData
        case decodingError
        case deviceError
        
        var description: String {
            switch self {
            case .invalidUrl:
                return "Invalid URL"
            case .noData:
                return "No data returned from the server"
            case .decodingError:
                return "Invalid server response"
            case .deviceError:
                return "No internet"
            }
        }
    }
    
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
