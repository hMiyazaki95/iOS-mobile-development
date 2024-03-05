//  Created by SFSU on 11/7/23.
//

import SwiftUI

struct UserNameInputView: View {
    
    @State
    private var text = ""
    
    var onSubmit: (String) -> Void
    
    var body: some View {
        VStack {
            TextField("", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Display") {
                onSubmit(text)
            }
        }.randomBackgroundColor()
    }
}
