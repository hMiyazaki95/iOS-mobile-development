import UIKit

class AddTasksViewController: UIViewController {
    
    // Note: We might be creating a memory leak here. We will revisit at the end of the semester
    var delegate: CreateTaskDelegate?
    
    let textField = UITextField(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray
        
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        let createTask = UIButton(frame: .zero)
        createTask.setTitle("create", for: .normal)
        createTask.setTitleColor(.blue, for: .normal)
        
        view.addSubview(createTask)
        
        createTask.translatesAutoresizingMaskIntoConstraints = false
        createTask.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16).isActive = true
        createTask.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        createTask.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        createTask.addTarget(self, action: #selector(createTaskButtonPressed), for: .touchUpInside)
    }
    
    @objc
    func createTaskButtonPressed(_ sender: UIButton) {
        let task = Task(
            id: UUID(),
            text: textField.text ?? "",
            isDone: false
        )
        delegate?.taskCreated(task)
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("AddTasksViewController was deinitialized")
    }
}
