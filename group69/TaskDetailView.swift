//
//  TaskDetailView.swift
//  group69
//
//  Created by Tech on 2026-02-06.
//

import SwiftUI

struct TaskDetailView: View {
    let taskId: String

    @EnvironmentObject private var dataStore: DataStore
    @State private var showEditSheet = false
    @State private var newCommentText: String = ""

    private var task: TaskItem? {
        dataStore.tasks.first(where: { $0.id.uuidString == taskId })
    }
    
    private func priorityColor(for priority: String) -> Color {
        switch priority {
        case "High":
            return .red
        case "Medium":
            return .yellow
        case "Low":
            return .green
        default:
            return .gray
        }
    }

    private func toggleComplete() {
        if let index = dataStore.tasks.firstIndex(where: { $0.id.uuidString == taskId }) {
            dataStore.tasks[index].isCompleted.toggle()
            dataStore.save()
        }
    }

    private func shareTask() {
        guard let task = task else { return }
        let shareText = """
        Task: \(task.title)
        Priority: \(task.priority)
        Description: \(task.description)
        Completed: \(task.isCompleted ? "Yes" : "No")
        Assignees: \(task.assignees.joined(separator: ", "))
        Subtasks:
        \(task.subtasks.map { "[\($0.status == .completed ? "x" : ($0.status == .inProgress ? "/" : " "))] " + $0.title }.joined(separator: "\n"))
        """
        
        let av = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(av, animated: true, completion: nil)
        }
    }

    private func addComment() {
        guard !newCommentText.isEmpty else { return }
        if let index = dataStore.tasks.firstIndex(where: { $0.id.uuidString == taskId }) {
            dataStore.tasks[index].comments.append(Comment(text: newCommentText))
            dataStore.save()
            newCommentText = ""
        }
    }

    private func changeSubtaskStatus(id: UUID, newStatus: SubtaskStatus) {
        withAnimation(.easeInOut) {
            if let taskIndex = dataStore.tasks.firstIndex(where: { $0.id.uuidString == taskId }),
               let subtaskIndex = dataStore.tasks[taskIndex].subtasks.firstIndex(where: { $0.id == id }) {
                dataStore.tasks[taskIndex].subtasks[subtaskIndex].status = newStatus
                dataStore.save()
            }
        }
    }

    private func statusIcon(for status: SubtaskStatus) -> String {
        switch status {
        case .pending: return "circle"
        case .inProgress: return "clock.fill"
        case .completed: return "checkmark.circle.fill"
        }
    }

    private func statusColor(for status: SubtaskStatus) -> Color {
        switch status {
        case .pending: return .gray
        case .inProgress: return .blue
        case .completed: return .green
        }
    }

    var body: some View {
        if let task {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .top) {
                            Text(task.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .strikethrough(task.isCompleted)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    toggleComplete()
                                }
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .blue)
                                    .font(.system(size: 28))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 10)
                }

                if !task.description.isEmpty {
                    Section("Description") {
                        Text(task.description)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.vertical, 4)
                    }
                }

                Section {
                    HStack {
                        DetailTag(label: task.priority, icon: "exclamationmark.circle.fill", color: priorityColor(for: task.priority))
                        Spacer()
                        DetailTag(label: task.dueDate.formatted(date: .abbreviated, time: .omitted), icon: "calendar", color: .secondary)
                    }
                    .padding(.vertical, 4)
                    
                    if !task.assignees.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Assignees")
                                .font(.caption.bold())
                                .foregroundColor(.secondary)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(task.assignees, id: \.self) { assignee in
                                        Text(assignee)
                                            .font(.caption)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(Color.blue.opacity(0.1))
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                        }
                    }
                }
                .listRowSeparator(.hidden)

                if !task.subtasks.isEmpty {
                    Section("Subtasks") {
                        ForEach(task.subtasks) { subtask in
                            HStack {
                                Menu {
                                    ForEach(SubtaskStatus.allCases, id: \.self) { status in
                                        Button(action: { changeSubtaskStatus(id: subtask.id, newStatus: status) }) {
                                            Label(status.rawValue, systemImage: statusIcon(for: status))
                                        }
                                    }
                                } label: {
                                    Image(systemName: statusIcon(for: subtask.status))
                                        .foregroundColor(statusColor(for: subtask.status))
                                        .font(.title3)
                                }
                                
                                Text(subtask.title)
                                    .strikethrough(subtask.status == .completed)
                                    .foregroundColor(subtask.status == .completed ? .secondary : .primary)
                                
                                Spacer()
                                
                                Text(subtask.status.rawValue)
                                    .font(.caption2)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(statusColor(for: subtask.status).opacity(0.1))
                                    .foregroundColor(statusColor(for: subtask.status))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }

                Section("Comments") {
                    ForEach(task.comments) { comment in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(comment.text)
                                .font(.body)
                            Text(comment.date, style: .relative)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    HStack {
                        TextField("Add a comment...", text: $newCommentText)
                            .textFieldStyle(.plain)
                        Button(action: {
                            withAnimation(.spring()) {
                                addComment()
                            }
                        }) {
                            Image(systemName: "paperplane.circle.fill")
                                .font(.title2)
                        }
                        .disabled(newCommentText.isEmpty)
                    }
                }

                Section {
                    Button(action: shareTask) {
                        Label("Share Task", systemImage: "square.and.arrow.up")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Task Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Edit") {
                    showEditSheet = true
                }
            }
            .sheet(isPresented: $showEditSheet) {
                TaskEditView(taskId: taskId)
            }
        }
    }
}

struct DetailTag: View {
    let label: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(label)
        }
        .font(.caption.bold())
        .foregroundColor(color)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(taskId: "")
            .environmentObject(DataStore())
    }
}
