import SwiftUI

struct LinesView: View {
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
        service.fetchLines(callback: { result in
            switch result {
            case .success(let lines):
                self.lines = lines
            case .failure(let error):
                self.errorString = error.description
            }
        })

    }
}
