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
