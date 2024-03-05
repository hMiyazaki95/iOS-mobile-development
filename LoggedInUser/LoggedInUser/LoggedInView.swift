import SwiftUI

struct LoggedInView: View {
    
    let user: User
    
    var body: some View {
        Text("Hello, \(user.name), you are logged in")
    }
}

struct LoggedInView_Previews: PreviewProvider {
    
    static let user = User(name: "Axel")
    
    static var previews: some View {
        LoggedInView(user: user)
    }
}
