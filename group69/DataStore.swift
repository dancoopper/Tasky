import SwiftUI

class SettingsStore: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    static let shared = SettingsStore()
}

class DataStore: ObservableObject {
    @Published var tasks: [TaskItem] = []

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("tasks.data")
    }

    func load() {
        do {
            let fileURL = try Self.fileURL()
            let data = try Data(contentsOf: fileURL)
            tasks = try JSONDecoder().decode([TaskItem].self, from: data)
        } catch {
            // No-op
        }
    }

    func save() {
        do {
            let fileURL = try Self.fileURL()
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL)
        } catch {
            // No-op
        }
    }
}