import UIKit




class AppEntryViewController: UIViewController {
    
//    var text: CustomBinding = CustomBinding(wrappedValue: "initial value")
    
    @OurCustomState
    var text: String = "initial value"
    
    // Only gets called ONCE in the lifecycle of the ViewController instance
    override func viewDidLoad() {
        super.viewDidLoad()

        let textField = TextField(_text)
        let label = Text(_text)
        
        setupView(textField: textField, label: label)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setupView(textField: TextField, label: Text) {
        self.view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        let safeArea = view.safeAreaLayoutGuide
        
        textField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        textField.backgroundColor = .red
        
        label.numberOfLines = 1
        
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16).isActive = true
        label.backgroundColor = .green
        
        label.text = "test"
    }


}



// Strings in Swift are "copy on write". They are value types but unless modiefied they behave like reference types in memory.
// var text: String



@propertyWrapper struct OurCustomState {
    let binding: CustomBinding
    
    var wrappedValue: String {
        get {
            binding.wrappedValue
        }
        set {
            binding.wrappedValue = newValue
        }
    }
    
    init(wrappedValue: String) {
        binding = CustomBinding(wrappedValue: wrappedValue)
    }
    
}
