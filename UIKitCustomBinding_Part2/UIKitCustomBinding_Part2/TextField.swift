import UIKit


class TextField: UITextField {
    
    // We will talk about memory management at the end of the course. We turned binding
    // into a weak var to prevent memory leaks
    weak var binding: CustomBinding?
    
    init(_ binding: CustomBinding) {
        self.binding = binding
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(textFieldHasUpdated), for: .editingChanged)
    }
    
    convenience init(_ state: OurCustomState) {
        self.init(state.binding)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc
    func textFieldHasUpdated(_ textField: UITextField?) {
        binding?.wrappedValue = textField?.text ?? ""
    }
}


class Text: UILabel, Observer {
    weak var binding: CustomBinding?
    
    init(_ binding: CustomBinding) {
        self.binding = binding
        super.init(frame: .zero)
        self.binding?.addObserver(self)
    }
    
    convenience init(_ state: OurCustomState) {
        self.init(state.binding)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // Text implements adheres to the Observer protocol, so it has to implement this method
    func observedValueHasUpdated(_ value: String) {
        text = value
    }
}
