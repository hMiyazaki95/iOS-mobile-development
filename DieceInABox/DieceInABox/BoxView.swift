import SwiftUI

protocol DieProtocol {
    var numberOfFaces: Int { get }
    func roll() -> Int
}


struct CustomValueDie: DieProtocol {
    var faceValues: [Int]
    
    var numberOfFaces: Int {
        return faceValues.count
    }
    
    func roll() -> Int {
        let shuffledArray = faceValues.shuffled()
        return shuffledArray[0]
    }
}


struct Die: DieProtocol {
    let numberOfFaces: Int
    
    func roll() -> Int {
        let dieFaces: ClosedRange<Int> = 1...numberOfFaces
        return Int.random(in: dieFaces)
    }
}

struct BoxView: View {
    
    let die: DieProtocol = Die(numberOfFaces: 6)
    
    // State instances are reference types
    @State // Annotation
    var rolledValue: Int = 1
    
//    var rolledValue: State<Int>
    
    var body: some View {
        VStack {
            Text("Rolled: \(rolledValue)")
        }
        .frame(width: 200, height: 200)
        .background(Color.brown)
        .border(.black, width: 2)
        .onTapGesture {
            shake()
        }
    }
    
    func shake() {
        self.rolledValue = die.roll()
    }
}

struct BoxView_Previews: PreviewProvider {
    static var previews: some View {
        BoxView()
    }
}



//struct BoxView: View {
//
//    let die = Die(numberOfFaces: 6)
//
//    // State instances are reference types
//
//    var rolledValue: State<Int>
//
//    init() {
//        rolledValue = State<Int>(initialValue: 1)
//    }
//
//    var body: some View {
//        VStack {
//            Text("Rolled: \(rolledValue.wrappedValue)")
//        }
//        .frame(width: 200, height: 200)
//        .background(Color.brown)
//        .border(.black, width: 2)
//        .onTapGesture {
//            shake()
//        }
//    }
//
//    func shake() {
//        self.rolledValue.wrappedValue = die.roll()
//    }
//}





//struct Die {
//    var numberOfFaces: Int
//
//    var rolledValue: Int = 1
//
//    mutating func roll() {
//        let dieFaces: ClosedRange<Int> = 1...numberOfFaces
//        rolledValue = Int.random(in: dieFaces)
//    }
//}
//
//struct BoxView: View {
//
//    @State
//    var die = Die(numberOfFaces: 6)
//
//    var body: some View {
//        VStack {
//            Text("Rolled: \(die.rolledValue)")
//        }
//        .frame(width: 200, height: 200)
//        .background(Color.brown)
//        .border(.black, width: 2)
//        .onTapGesture {
//            shake()
//        }
//    }
//
//    func shake() {
//        die.roll()
//    }
//}
