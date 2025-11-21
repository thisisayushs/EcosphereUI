//
//  DarkBackground.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 03/01/25.
//

import SwiftUI

struct DarkBackground: View {
    var body: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.2)]),
            center: .center,
            startRadius: 20,
            endRadius: 400
        )
        .ignoresSafeArea()
    }
}

#Preview {
    DarkBackground()
        .preferredColorScheme(.dark)
}
