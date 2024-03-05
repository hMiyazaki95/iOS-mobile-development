import Foundation

// http://api.511.org/transit/timetable?api_key=f5c4e5c7-f694-4c6a-adcb-5e7fa3c6ee34&operator_id=SF&line_id=N&Format=json
// MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))

struct MuniService {
    
    // function that takes a function as paramater and returns nothing

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
                let stops = response.Contents.dataObjects.ScheduledStopPoint.compactMap({ rawDataTyp in
                    Stop(rawDataTyp)
                })

                completionHandler(.success(stops))
            } catch {
                completionHandler(.failure(.decodingError))
            }
        }.resume()
    }
}
