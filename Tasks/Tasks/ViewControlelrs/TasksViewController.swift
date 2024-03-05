import UIKit

protocol CreateTaskDelegate {
    func taskCreated(_ newTask: Task)
}

class TasksViewController: UIViewController, CreateTaskDelegate, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView = UITableView(frame: .zero)
    
    var tasks: [Task] = [
        Task(text: "Feed cats", isDone: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        tableView.backgroundColor = .blue
        
        let addTasksButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTasksPressed))
        navigationItem.rightBarButtonItem = addTasksButton
        title = "Tasks"
    }
    
    @objc
    func addTasksPressed(_ sender: UIBarButtonItem) {
        let addTasksViewController = AddTasksViewController()
        addTasksViewController.delegate = self
        navigationController?.pushViewController(addTasksViewController, animated: true)
    }
    
    // MARK: - CreateTaskDelegate
    func taskCreated(_ newTask: Task) {
        print("Delegate received new task: \(newTask.text)")
        tasks.append(newTask)
        print("All tasks created: \(tasks)")
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.text
        if task.isDone {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = tasks[indexPath.row]
        task.isDone = !task.isDone
        tasks[indexPath.row] = task
        tableView.reloadData()
        print(task.text)
    }
}








//deinit {
//    print("THIS SHOULD NOT PRINT (since the tasks view controller is thre root view controller of our navigation controller): TasksViewController was deinitialized")
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    print("TasksViewController disappeared")
//}
//
//override func viewWillAppear(_ animated: Bool) {
//    print("TasksViewController will appear")
//}
