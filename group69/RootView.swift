//
//  RootView.swift
//  group69
//
//  Primary author: Jonathan Cao (101480537)
//
//  Other editors:
//  - Sokmontrey Sythat (101477705): Splash vs main list switch timing.
//  - Samuel Browne (101481884): Preview `environmentObject` setup.
//

import SwiftUI

struct RootView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
            } else {
                TaskListView()
            }
        }
        // Delay hides splash before showing `TaskListView`; must run on main queue for UI updates.
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(DataStore())
    }
}
.
