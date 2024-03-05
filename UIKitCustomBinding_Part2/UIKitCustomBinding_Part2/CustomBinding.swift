import Foundation

// Pattern that we are using here: A form of delegation.

protocol Observer {
    func observedValueHasUpdated(_ value: String)
}

class CustomBinding {
    
    private var observers: [Observer] = []
    
    func addObserver(_ observer: Observer) {
        self.observers.append(observer)
    }

    var wrappedValue: String {
        didSet {
            for observer in observers {
                observer.observedValueHasUpdated(wrappedValue)
            }
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
