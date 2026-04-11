//
//  group69App.swift
//  group69
//
//  Primary author: Samuel Browne (101481884)
//
//  Other editors:
//  - Sokmontrey Sythat (101477705): Scene-phase hooks for reload/save timing.
//  - Jonathan Cao (101480537): `DataStore` / `SettingsStore` injection and color scheme.
//

import SwiftUI

@main
struct group69App: App {
    @StateObject private var dataStore = DataStore()
    @StateObject private var settingsStore = SettingsStore.shared
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(dataStore)
                .environmentObject(settingsStore)
                .preferredColorScheme(settingsStore.isDarkMode ? .dark : .light)
                // When returning to foreground, reload from disk in case another process touched the file.
                // When leaving active state, persist so background kills do not lose edits.
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        dataStore.save()
                    } else if phase == .active {
                        dataStore.load()
                    }
                }
        }
    }
}
.
