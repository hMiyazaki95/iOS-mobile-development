import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Box with Die")
            BoxView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
