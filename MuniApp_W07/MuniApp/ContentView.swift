import SwiftUI

struct ContentView: View {
    
    let service = MuniService()
    
    @State
    var lines: [LineElement] = []
    
    
    @State
    var errorString: String?
    
    
    var body: some View {
        VStack {
            if let errorString = errorString {
                Text(errorString)
                Button("Retry") {
                    self.errorString = nil
                    updateLines()
                }
            } else {
                List {
                    ForEach(lines) { line in
                        Text("\(line.id) \(line.name)")
                    }
                }
            }
        }
        .onAppear {
            updateLines()
        }
        .refreshable {
            updateLines()
        }
        .padding()
    }
    
    
    func updateLines() {
//        service.fetchLines { (lines: [LineElement]) in
//            self.lines = lines
//        }
        
//        service.fetchLines(successHandler: { (lines: [LineElement]) in
//           self.lines = lines
//        }, failureHandler: { errorText in
//            self.errorString = errorText
//        })
        
//        service.fetchLines(callback: { (maybeLines: [LineElement]?) in
//            if let lines = maybeLines {
//                self.lines = lines
//            } else {
//                self.errorString = "Error loading lines"
//            }
//        })
        
        service.fetchLines(callback: { result in
            switch result {
            case .success(let lines):
                self.lines = lines
            case .failure(let error):
                self.errorString = error.description
            }
        })
        
        
        service.fetchStops { result in
            switch result {
            case .success(let stops):
                print(stops)
                // TODO: Do something with the response
            case .failure(let error):
                self.errorString = error.description
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
