//
//  MainView.swift
//  group69
//
//  Created by Tech on 2026-02-06.
//

import SwiftUI

struct TaskListView: View {
    @State private var navigationPath = NavigationPath()
    @State private var showCreateSheet = false

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                Section {
                    NavigationLink(value: Route.detail("Task 1")) {
                        HStack(spacing: 12) {
                            Image(systemName: "circle")
                                .foregroundColor(.blue)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Task Title")
                                    .font(.body)
                                    .fontWeight(.medium)

                                Text("Due Jan 25")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Your To-Do")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 6) {
                        Image(systemName: "calendar.badge.plus")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("Tasky")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showCreateSheet = true
                    } label: {
                        Image(systemName: "plus")
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
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}