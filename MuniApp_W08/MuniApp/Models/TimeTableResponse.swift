
import Foundation

struct TimeTableResponse: Decodable {
    struct Content: Decodable {
        struct ServiceFrame: Decodable {
            struct routes: Decodable {
                struct Route: Decodable {
                    struct pointsInSequence: Decodable {
                        struct PointOnRoute: Decodable {
                            struct PointRef: Decodable {
                                let ref: String
                                let type: String
                            }
                            let id: String
                            let PointRef: PointRef
                        }
                        let PointOnRoute: [PointOnRoute]
                    }
                    let id: String
                    let Name: String
                    let pointsInSequence: pointsInSequence
                }
                
                let Route: [Route]
            }
            let routes: routes
        }
        let ServiceFrame: ServiceFrame
    }
    let Content: Content
}
