//
//  SplashView.swift
//  group69
//
//  Primary author: Samuel Browne (101481884)
//
//  Other editors:
//  - Sokmontrey Sythat (101477705): Scale/opacity animation tuning.
//  - Jonathan Cao (101480537): Safe area and layout checks.
//

import SwiftUI

struct SplashView: View {
    @State private var scale = 0.8
    @State private var opacity = 0.5

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "calendar.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(.blue)

                Text("Tasky")
                    .font(.largeTitle)
                    .fontWeight(.medium)
            }
            .scaleEffect(scale)
            .opacity(opacity)
            // Simple entrance animation; state changes drive `scaleEffect`/`opacity`.
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2)) {
                    scale = 1.0
                    opacity = 1.0
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
