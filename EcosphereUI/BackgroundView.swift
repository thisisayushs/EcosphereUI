//
//  BackgroundView.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 02/26/25.
//

import SwiftUI

struct BackgroundView: View {
    var opacity: Double = 0.0
    var body: some View {
        Image("TransluscentDesignBackground")
            .resizable()
            .scaledToFit()
            .overlay {
                Color.black.opacity(opacity)
            }
            .scaleEffect(2.0)
            .blur(radius: 24)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
        .preferredColorScheme(.dark)
}
