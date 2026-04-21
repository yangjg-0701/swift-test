import Foundation

class StorageService {
    static let key = "tasks"

    static func save(_ tasks: [Task]) {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func load() -> [Task] {
        if let data = UserDefaults.standard.data(forKey: key),
           let tasks = try? JSONDecoder().decode([Task].self, from: data) {
            return tasks
        }
        return []
    }
}