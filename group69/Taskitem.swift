import Foundation
import SwiftUI

enum SubtaskStatus: String, Codable, CaseIterable {
    case pending = "Pending"
    case inProgress = "In Progress"
    case completed = "Completed"
}

struct Subtask: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var status: SubtaskStatus = .pending
}

struct Comment: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var text: String
    var date: Date = Date()
}

struct TaskItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var priority: String
    var description: String = ""
    var assignees: [String] = []
    var subtasks: [Subtask] = []
    var comments: [Comment] = []
    var isCompleted: Bool = false
    var dueDate: Date = Date()
}
