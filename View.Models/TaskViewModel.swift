import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            StorageService.save(tasks)
        }
    }

    init() {
        tasks = StorageService.load()
    }

    func addTask(title: String, category: String) {
        tasks.append(Task(title: title, category: category))
    }

    func toggle(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
        }
    }

    func delete(offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}