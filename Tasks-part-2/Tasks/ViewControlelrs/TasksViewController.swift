import UIKit
import CoreData

protocol CreateTaskDelegate {
    func taskCreated(_ newTask: Task)
}

class TasksViewController: UIViewController, CreateTaskDelegate, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView = UITableView(frame: .zero)
    
    var tasks: [Task] = []
    
    let store = Store()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try tasks = store.fetchTasks()
        } catch {
            print(error)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        
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
        do {
            try store.insert(newTask)
            let insertIndex = tasks.startIndex
            let indexPath = IndexPath(row: insertIndex, section: 0)
            tasks.insert(newTask, at: insertIndex)
            tableView.insertRows(at: [indexPath], with: .fade)
        } catch {
            print("ERROR:", error)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
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
        do {
            try store.update(isDone: task.isDone, for: task.id)
            tasks[indexPath.row] = task
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    // If this method is present slide to delete on UITablview is available
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let task = tasks[indexPath.row]
        do {
            try store.delete(taskWithId: task.id)
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } catch {
            print(error)
        }
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
