//
//  TaskDetailView.swift
//  group69
//
//  Created by Tech on 2026-02-06.
//

import SwiftUI

struct TaskDetailView: View {
    let taskId: String
    @State private var showEditSheet = false

    var body: some View {
        List {
            Section {
                Text("Project Task Title")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.vertical, 8)
            }

            Section {
                LabeledContent("Priority") {
                    Label("High", systemImage: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                }

                LabeledContent("Due Date") {
                    Label("Jan 25, 6:00 PM", systemImage: "calendar")
                }
            }

            Section("Description") {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    .foregroundColor(.secondary)
                    .padding(.vertical, 4)
            }
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


struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(taskId: "")
    }
}
