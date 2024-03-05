import SwiftUI

struct ContentView: View {
    
    let service = MuniService()
    
    @State
    var lines: [LineElement] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(lines) { line in
                    Text("\(line.id) \(line.name)")
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
        service.fetchLines({ (lines: [LineElement]) in
            self.lines = lines
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
