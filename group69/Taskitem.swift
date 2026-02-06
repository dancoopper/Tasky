//
//  TaskItem.swift
//  group69
//
//  Created by Tech on 2026-02-06.
//

import Foundation

struct TaskItem: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String
    var priority: String
}

