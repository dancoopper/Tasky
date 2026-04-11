//
//  Taskitem.swift
//  group69
//
//  Primary author: Sokmontrey Sythat (101477705)
//
//  Other editors:
//  - Jonathan Cao (101480537): Ensured `Codable` models match `DataStore` JSON encoding/decoding.
//  - Samuel Browne (101481884): Refined subtask/comment fields used in list and detail screens.
//

import Foundation
import SwiftUI

/// Workflow state for a single subtask; stored as raw `String` in JSON.
enum SubtaskStatus: String, Codable, CaseIterable {
    case pending = "Pending"
    case inProgress = "In Progress"
    case completed = "Completed"
}

/// One checklist line under a task; `Identifiable` enables stable `ForEach` rows.
struct Subtask: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var status: SubtaskStatus = .pending
}

/// User note on a task; `date` defaults to creation time for relative display in the UI.
struct Comment: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var text: String
    var date: Date = Date()
}

/// Top-level task record persisted as one element of the `[TaskItem]` array in `tasks.data`.
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
.
