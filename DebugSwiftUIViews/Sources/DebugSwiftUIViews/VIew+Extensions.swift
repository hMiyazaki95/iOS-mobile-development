//  Created by SFSU on 11/7/23.
//

import SwiftUI

public extension View {
    
    func randomBackgroundColor() -> some View  {
        return self.background(Color.random().opacity(0.2))
    }
    
    func debugDrawCount() -> some View {
        VStack {
            let typeString = "\(type(of: self))"
            Text("Draw count: \(DebugManager.shared.incrementDrawCount(key: typeString))")
            self
        }
    }
}
