import SwiftUI

struct LoggedOutView: View {
    
    @State
    var userName: String = ""
    
    @Binding
    var loggedInState: LoginState
    
    init(loggedInState: Binding<LoginState>) {
        _loggedInState = loggedInState
    }
    
    var body: some View {
        VStack {
            Text("User Name")
            TextField("", text: $userName)
                .textFieldStyle(.roundedBorder)
            Button("OK") {
                // We are skipping the part where we fetch the user.
                // For this example we just return a logged in user
                let user = User(name: userName)
                loggedInState = .loggedIn(user)
            }
        }.padding()
    }
}

//struct LoggedOutView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoggedOutView()
//    }
//}
