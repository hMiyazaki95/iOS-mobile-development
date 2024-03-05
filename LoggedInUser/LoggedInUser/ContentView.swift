//  Created by SFSU on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @State
    var loginState: LoginState = .loggedOut
    
    var body: some View {
        switch loginState {
        case .loggedOut:
            LoggedOutView(loggedInState: $loginState)
        case .loggedIn(let user):
            LoggedInView(user: user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
