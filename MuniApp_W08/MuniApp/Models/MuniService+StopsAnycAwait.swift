
import Foundation

extension MuniService {
    
    // function that takes no parameters, suspends but doesn't block execution, then returns our stops array
    func fetchStops() async throws -> [Stop] {
        let urlString = "http://api.511.org/transit/stops?api_key=f5c4e5c7-f694-4c6a-adcb-5e7fa3c6ee34&operator_id=SF&Format=json"
        guard let url = URL(string: urlString) else {
            // TODO: Deal with this error case
            throw ServiceError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        print(response)
        let decoder = JSONDecoder()
        
        let stopsResponse = try decoder.decode(StopsResponse.self, from: data)
        let stops = stopsResponse.Contents.dataObjects.ScheduledStopPoint.compactMap { rawDataType in
            Stop(rawDataType)
        }
        return stops
    }
}
