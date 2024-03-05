import SwiftUI

struct RouteMapView: View {
    
    let service = MuniService()
    
    @State
    var errorString: String?
    
    @State
    var stops: [Stop] = []
    
    var body: some View {
        List {
            ForEach(stops) { stop in
                Text(stop.name)
            }
        }
        .task {
            await updateMap()
        }
//        .onAppear {
//            print("Before creatig a Task")
//            Task {
//                await updateMap()
//                print("Done fetsching")
//            }
//            print("After creating a task")
//        }
    }
    
    func updateMap() async {
        do {
            stops = try await service.fetchStops()
        } catch {
            errorString = "\(error)"
        }
        
//        service.fetchStops { result in
//            switch result {
//            case .success(let stops):
//                print(stops)
//                // TODO: Do something with the response
//            case .failure(let error):
//                self.errorString = error.description
//            }
//        }
    }
}
