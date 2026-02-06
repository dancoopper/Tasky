//
//  TaskEditView.swift
//  group69
//
//  Created by Tech on 2026-02-06.
//

import SwiftUI

struct TaskEditView: View {
    let taskId: String?
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var priority: String = "Medium"
    @State private var date = Date()

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
                    DatePicker("Due Date", selection: $date, displayedComponents: .date)
                }
                
                Section {
                    Button(taskId == nil ? "Create Task" : "Save Changes") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .bold()
                    .foregroundColor(.blue)
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
    }
}