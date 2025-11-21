//
//  LightBackground.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 03/01/25.
//

import SwiftUI

struct LightBackground: View {
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            Color.white.opacity(0.8)
                .blur(radius: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .ignoresSafeArea()
            Color.black.opacity(0.18)
                .scaleEffect(1.5)
                .blur(radius: 20)
        }
    }
}

#Preview {
    LightBackground()
        .preferredColorScheme(.light)
}
