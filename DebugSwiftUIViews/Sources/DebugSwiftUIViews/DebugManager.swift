//  Created by SFSU on 11/7/23.
//

import Foundation

// DebugManager is a singleton. Use this pattern with great cauction. You are
// creating global state, which makes debugging really difficult.
// Singletons have to be reference types since value types are copied when passed around
internal class DebugManager {
    
    internal static var shared = DebugManager()
    
    // True singletons have private initializers to prevent the cration of
    // aditional instances
    private init() { }
    
    private var drawCounts: [String: Int] = [:]
    
    internal func incrementDrawCount(key: String) -> Int {
        var currentCount = drawCounts[key] ?? 0
        currentCount += 1
        drawCounts[key] = currentCount
        return currentCount
    }
}
