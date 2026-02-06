//
//  SplashView.swift
//  group69
//
//  Created by Tech on 2026-02-06.
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
