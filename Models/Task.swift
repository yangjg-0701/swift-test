import Foundation

struct Task: Identifiable, Codable {
    let id = UUID()
    var title: String
    var category: String
    var isDone: Bool = false
}