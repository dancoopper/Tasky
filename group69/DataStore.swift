//
//  DataStore.swift
//  group69
//
//  Primary author: Jonathan Cao (101480537)
//
//  Other editors:
//  - Sokmontrey Sythat (101477705): Confirmed task array shape matches `TaskItem` model.
//  - Samuel Browne (101481884): `SettingsStore` + `@AppStorage` wiring for appearance.
//

import SwiftUI

/// Persists a single boolean in `UserDefaults` via `@AppStorage` for dark/light mode.
class SettingsStore: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    static let shared = SettingsStore()
}

/// Observable store for all tasks; JSON file I/O is synchronous on the main actor path used by SwiftUI.
class DataStore: ObservableObject {
    @Published var tasks: [TaskItem] = []

    /// Documents directory is writable; `tasks.data` is the app’s private JSON snapshot.
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("tasks.data")
    }

    /// **Reading data:** Loads `[TaskItem]` from disk; on first launch or decode failure, leaves `tasks` unchanged (usually empty).
    func load() {
        do {
            let fileURL = try Self.fileURL()
            let data = try Data(contentsOf: fileURL)
            tasks = try JSONDecoder().decode([TaskItem].self, from: data)
        } catch {
            // Intentionally silent: no file yet or corrupt JSON should not crash the UI.
        }
    }

    /// **Writing data:** Overwrites `tasks.data` with the full encoded array (replace, not merge).
    func save() {
        do {
            let fileURL = try Self.fileURL()
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL)
        } catch {
            // Intentionally silent: disk full / permission issues are rare in simulator; production apps might log.
        }
    }
}