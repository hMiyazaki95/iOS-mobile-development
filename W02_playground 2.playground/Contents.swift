import UIKit

// values from 1 - 6
let dieFaces: ClosedRange<Int> = 1...6
//        let dieFace: Range<Int> = 0..<6

// for-in-loop
for faceValue in dieFaces {
//    print(faceValue)
}


// When assigning value types to other variables or passing them into functions we create a copy
var myInteger: Int = 0
var otherInteger = myInteger

// Classes in swift are reference types
class Box {
    var rolledValue: Int = 1
    
    func shake() {
        let dieFaces: ClosedRange<Int> = 1...6
        let randomValue = Int.random(in: dieFaces)
        rolledValue = randomValue
    }
}

//let box: Box = Box()
//box.shake()
//print(box.rolledValue)


// In Swift struct can have
// - functions


class BoxContents {
    var value: Int = 1
}

// Struct in swift are value types
struct ImmutableBox {
    let contents: BoxContents = BoxContents()
    
    func shake() {
        let dieFaces: ClosedRange<Int> = 1...6
        let randomValue = Int.random(in: dieFaces)
        contents.value = randomValue
    }
}

let immutableBoxInstance = ImmutableBox()
immutableBoxInstance.shake()
print(immutableBoxInstance.contents.value)
