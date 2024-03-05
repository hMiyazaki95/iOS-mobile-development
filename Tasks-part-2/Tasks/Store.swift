import Foundation
import CoreData

extension Task {
    init(_ entity: TaskEntity) throws {
        guard let id = entity.id else {
            throw StoreError.missingProperty
        }
        guard let text = entity.text else {
            throw StoreError.missingProperty
        }
        self.init(id: id, text: text, isDone: entity.isDone)
    }
    
    func entity(in context:  NSManagedObjectContext) {
        let entity = TaskEntity(context: context)
        entity.id = self.id
        entity.text = self.text
        entity.isDone = self.isDone
    }
}



enum StoreError: Error {
    case missingProperty
    case noEntityWithThatId
}

class Store {
    
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { description, maybeError in
            // - Migrations can prevent errors where a user has an incompatible database (you created a breaking change to your core data tables)
            print(description.url?.path(percentEncoded: false) ?? "")
        }
    }
    
    func insert(_ task: Task) throws {
        let context = container.viewContext
        task.entity(in: context)
        try context.save()
    }
    
    func fetchTasks() throws -> [Task] {
        let context = container.viewContext
        let request = TaskEntity.fetchRequest()
        let entities = try context.fetch(request)
        return try entities.map { (entity: TaskEntity) in
            try Task(entity)
        }
    }
    
    func update(isDone: Bool, for taskId: UUID) throws {
        let context = container.viewContext
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", taskId as CVarArg)
        request.fetchLimit = 1
        guard let entity = try context.fetch(request).first else {
            throw StoreError.noEntityWithThatId
        }
        entity.isDone = isDone
        try context.save()
    }
    
    func delete(taskWithId taskId: UUID) throws {
        let context = container.viewContext
        let request = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", taskId as CVarArg)
        request.fetchLimit = 1
        guard let entity = try context.fetch(request).first else {
            throw StoreError.noEntityWithThatId
        }
        context.delete(entity)
        try context.save()
    }
}
