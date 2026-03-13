//
//  TaskEditView.swift
//  group69
//
//  Created by Tech on 2026-02-06.
//

import SwiftUI

struct TaskEditView: View {
    let taskId: String?

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var dataStore: DataStore

    @State private var title: String = ""
    @State private var priority: String = "Medium"
    @State private var description: String = ""
    @State private var assigneesText: String = ""
    @State private var isCompleted: Bool = false
    @State private var dueDate = Date()
    @State private var subtasks: [Subtask] = []
    @State private var newSubtaskTitle: String = ""

    private func onSave() {
        let assignees = assigneesText.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
        
        if let taskId, let index = dataStore.tasks.firstIndex(where: { $0.id.uuidString == taskId }) {
            dataStore.tasks[index].title = title
            dataStore.tasks[index].priority = priority
            dataStore.tasks[index].description = description
            dataStore.tasks[index].assignees = assignees
            dataStore.tasks[index].isCompleted = isCompleted
            dataStore.tasks[index].dueDate = dueDate
            dataStore.tasks[index].subtasks = subtasks
        } else {
            let newTask = TaskItem(
                title: title,
                priority: priority,
                description: description,
                assignees: assignees,
                subtasks: subtasks,
                isCompleted: isCompleted,
                dueDate: dueDate
            )
            dataStore.tasks.append(newTask)
        }
        
        dataStore.save()
        dismiss()
    }

    private func addSubtask() {
        guard !newSubtaskTitle.isEmpty else { return }
        subtasks.append(Subtask(title: newSubtaskTitle))
        newSubtaskTitle = ""
    }

    private func deleteSubtask(at offsets: IndexSet) {
        subtasks.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Info")) {
                    TextField("Task Title", text: $title)
                    Picker("Priority", selection: $priority) {
                        Text("High").tag("High")
                        Text("Medium").tag("Medium")
                        Text("Low").tag("Low")
                    }
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    Toggle("Is Completed", isOn: $isCompleted)
                }

                Section(header: Text("Details")) {
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...10)
                    TextField("Assignees (comma-separated)", text: $assigneesText)
                }

                Section(header: Text("Subtasks")) {
                    ForEach($subtasks) { $subtask in
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Subtask", text: $subtask.title)
                                Picker("Status", selection: $subtask.status) {
                                    ForEach(SubtaskStatus.allCases, id: \.self) { status in
                                        Text(status.rawValue).tag(status)
                                    }
                                }
                                .pickerStyle(.menu)
                                .font(.caption)
                            }
                        }
                    }
                    .onDelete(perform: deleteSubtask)

                    HStack {
                        TextField("New Subtask", text: $newSubtaskTitle)
                        Button(action: {
                            withAnimation(.spring()) {
                                addSubtask()
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                        }
                        .disabled(newSubtaskTitle.isEmpty)
                    }
                }

                Section {
                    Button(taskId == nil ? "Create Task" : "Save Changes", action: onSave)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                        .foregroundColor(.blue)
                }
            }
            .onAppear {
                if let taskId, let task = dataStore.tasks.first(where: { $0.id.uuidString == taskId }) {
                    title = task.title
                    priority = task.priority
                    description = task.description
                    assigneesText = task.assignees.joined(separator: ", ")
                    isCompleted = task.isCompleted
                    dueDate = task.dueDate
                    subtasks = task.subtasks
                }
            }
            .navigationTitle(taskId == nil ? "New Task" : "Edit Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(taskId: nil)
            .environmentObject(DataStore())
    }
}