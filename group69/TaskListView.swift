//
//  MainView.swift
//  group69
//
//  Created by Tech on 2026-02-06.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var dataStore: DataStore
    @EnvironmentObject private var settingsStore: SettingsStore

    @State private var navigationPath = NavigationPath()
    @State private var showCreateSheet = false
    @State private var showSettingsSheet = false

    private var activeTasks: [TaskItem] {
        dataStore.tasks.filter { !$0.isCompleted }
    }

    private var completedTasks: [TaskItem] {
        dataStore.tasks.filter { $0.isCompleted }
    }

    private func onDelete(at offsets: IndexSet, in tasks: [TaskItem]) {
        for offset in offsets {
            let taskToDelete = tasks[offset]
            if let index = dataStore.tasks.firstIndex(where: { $0.id == taskToDelete.id }) {
                dataStore.tasks.remove(at: index)
            }
        }
        dataStore.save()
    }
    
    private func priorityColor(for priority: String) -> Color {
        switch priority {
        case "High":
            return .red
        case "Medium":
            return .orange
        case "Low":
            return .blue
        default:
            return .gray
        }
    }

    private func shareHistory() {
        let historyText = "Completed Tasks:\n" + completedTasks.map { "- \($0.title)" }.joined(separator: "\n")
        let av = UIActivityViewController(activityItems: [historyText], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(av, animated: true, completion: nil)
        }
    }

    private func toggleComplete(task: TaskItem) {
        withAnimation(.spring()) {
            if let index = dataStore.tasks.firstIndex(where: { $0.id == task.id }) {
                dataStore.tasks[index].isCompleted.toggle()
                dataStore.save()
            }
        }
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                if !activeTasks.isEmpty {
                    Section("Active Tasks") {
                        ForEach(activeTasks) { task in
                            TaskRow(task: task, toggleComplete: { toggleComplete(task: task) })
                                .background(
                                    NavigationLink(value: Route.detail(task.id.uuidString)) {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                )
                                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing).combined(with: .opacity)))
                        }
                        .onDelete { onDelete(at: $0, in: activeTasks) }
                    }
                }

                if !completedTasks.isEmpty {
                    Section("History") {
                        ForEach(completedTasks) { task in
                            TaskRow(task: task, toggleComplete: { toggleComplete(task: task) })
                                .background(
                                    NavigationLink(value: Route.detail(task.id.uuidString)) {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                )
                                .transition(.opacity)
                        }
                        .onDelete { onDelete(at: $0, in: completedTasks) }
                        
                        Button(action: shareHistory) {
                            Label("Share History", systemImage: "square.and.arrow.up")
                                .font(.subheadline.bold())
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.default, value: dataStore.tasks)
            .navigationTitle("Tasky")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSettingsSheet = true
                    } label: {
                        Image(systemName: "line.3.horizontal.circle")
                            .font(.title3)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showCreateSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .symbolRenderingMode(.hierarchical)
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let taskId):
                    TaskDetailView(taskId: taskId)
                case .edit(let taskId):
                    TaskEditView(taskId: taskId)
                }
            }
            .sheet(isPresented: $showCreateSheet) {
                TaskEditView(taskId: nil)
            }
            .sheet(isPresented: $showSettingsSheet) {
                SettingsView()
            }
        }
    }
}

struct TaskRow: View {
    let task: TaskItem
    let toggleComplete: () -> Void

    private func priorityColor(for priority: String) -> Color {
        switch priority {
        case "High": return .red
        case "Medium": return .orange
        case "Low": return .blue
        default: return .gray
        }
    }

    private var dueDateInfo: (text: String, color: Color) {
        let now = Date()
        let calendar = Calendar.current
        
        if task.isCompleted {
            return (task.dueDate.formatted(date: .abbreviated, time: .omitted), .secondary)
        }
        
        if calendar.isDateInYesterday(task.dueDate) || task.dueDate < now {
            return ("Overdue: " + task.dueDate.formatted(date: .abbreviated, time: .omitted), .red)
        } else if calendar.isDateInToday(task.dueDate) {
            return ("Due Today", .orange)
        } else if calendar.isDateInTomorrow(task.dueDate) {
            return ("Due Tomorrow", .blue)
        } else {
            return (task.dueDate.formatted(date: .abbreviated, time: .omitted), .secondary)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Button(action: toggleComplete) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .blue)
                        .font(.system(size: 24))
                }
                .buttonStyle(.plain)

                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.headline)
                        .strikethrough(task.isCompleted)
                        .foregroundColor(task.isCompleted ? .secondary : .primary)
                    
                    HStack(spacing: 8) {
                        Text(dueDateInfo.text)
                            .font(.caption2.bold())
                            .foregroundColor(dueDateInfo.color)
                        
                        Text("•")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        Text(task.priority)
                            .font(.system(size: 10, weight: .black))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(priorityColor(for: task.priority).opacity(0.15))
                            .foregroundColor(priorityColor(for: task.priority))
                            .clipShape(Capsule())
                    }
                }
                
                Spacer()
                
                if !task.assignees.isEmpty {
                    HStack(spacing: -8) {
                        ForEach(task.assignees.prefix(3), id: \.self) { assignee in
                            Text(String(assignee.prefix(1)).uppercased())
                                .font(.system(size: 10, weight: .bold))
                                .frame(width: 24, height: 24)
                                .background(Color.blue.opacity(0.2))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(UIColor.systemBackground), lineWidth: 2))
                        }
                        if task.assignees.count > 3 {
                            Text("+\(task.assignees.count - 3)")
                                .font(.system(size: 8, weight: .bold))
                                .frame(width: 24, height: 24)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(UIColor.systemBackground), lineWidth: 2))
                        }
                    }
                }
            }
            
            if !task.subtasks.isEmpty {
                VStack(spacing: 6) {
                    let total = task.subtasks.count
                    let completed = task.subtasks.filter { $0.status == .completed }.count
                    let inProgress = task.subtasks.filter { $0.status == .inProgress }.count
                    let progress = Double(completed) / Double(total)
                    
                    HStack {
                        Label("\(completed)/\(total)", systemImage: "checklist")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.secondary)
                        
                        if inProgress > 0 {
                            Text("• \(inProgress) in progress")
                                .font(.system(size: 10))
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        Text("\(Int(progress * 100))%")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                    
                    ProgressView(value: progress)
                        .tint(progress == 1.0 ? .green : .blue)
                        .scaleEffect(x: 1, y: 0.7, anchor: .center)
                }
                .padding(.leading, 36)
            }
        }
        .padding(.vertical, 8)
    }
}

struct SettingsView: View {
    @EnvironmentObject var settingsStore: SettingsStore
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $settingsStore.isDarkMode)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environmentObject(DataStore())
    }
}