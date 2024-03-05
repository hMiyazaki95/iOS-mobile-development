//  Created by SFSU on 11/7/23.
//

import SwiftUI
import DebugSwiftUIViews

struct ContentView: View {

    @State
    private var display = ""
    
    var body: some View {
        VStack {
            UserNameInputView { newValue in
                display = newValue
            }
            Text(display)
            Spacer()
        }
        .padding()
        .randomBackgroundColor()
        .debugDrawCount()
    }
}

#Preview {
    ContentView()
}
