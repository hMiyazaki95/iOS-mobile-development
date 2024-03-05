import Foundation

enum TransitMode {
    case bus, metro, other(String)
}

struct LineElement: Identifiable {
    let id: String
    let name: String
    let mode: TransitMode
    
    init(id: String, name: String, mode: TransitMode) {
        self.id = id
        self.name = name
        self.mode = mode
    }
    
    init(rawLineElement: RawLineElement) {
        self.id = rawLineElement.Id
        self.name = rawLineElement.Name
        
        switch rawLineElement.TransportMode {
        case "bus":
            self.mode = .bus
        case "metro":
            self.mode = .metro
        default:
            self.mode = .other(rawLineElement.TransportMode)
        }
    }
}


struct RawLineElement: Decodable {
    let Id: String
    let Name: String
    let TransportMode: String
    let PublicCode: String
    let SiriLineRef: String
    let Monitored: Bool
    let OperatorRef: String
}

struct StopsResponse: Decodable {
    struct Content: Decodable {
        struct dataObjects: Decodable {
            struct ScheduledStopPoint: Decodable {
                struct Location: Decodable {
                    let Longitude: String
                    let Latitude: String
                }
                let id: String
                let Name: String
                let Location: Location
            }
            let ScheduledStopPoint: [ScheduledStopPoint]
        }
        let dataObjects: dataObjects
    }
    let Contents: Content
}


import CoreLocation

struct Stop {
    let id: String
    let name: String
    let location: CLLocationCoordinate2D
    
    init?(_ rawType: StopsResponse.Content.dataObjects.ScheduledStopPoint) {
        self.id = rawType.id
        self.name = rawType.Name
        guard
            let lat = Double(rawType.Location.Latitude),
            let lon = Double(rawType.Location.Longitude)
        else {
            return nil
        }
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}



