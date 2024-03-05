//  Created by SFSU on 11/7/23.
//

import SwiftUI

public extension Color {
    static func random() -> Color {
        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}
