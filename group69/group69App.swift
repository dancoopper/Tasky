//
//  group69App.swift
//  group69
//
//  Created by Tech on 2026-02-06.
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
