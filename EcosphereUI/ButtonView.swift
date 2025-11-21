//
//  ButtonView.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 02/26/25.
//

import SwiftUI

struct ButtonView: View {
    var content: String = "Tap"
    var body: some View {
        Text(content)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .frame(width: 360, height: 60)
            .background {
                TransparentBlurView(removeAllFilters: true)
                    .blur(radius: 9, opaque: true)
                    .background(.white.opacity(0.05))
                    .clipShape(.capsule)
                    .frame(width: 360, height: 60)
                    .background() {
                        Capsule()
                            .stroke(.white.opacity(0.3), lineWidth: 1.5)
                    }
                    .shadow(color: .black.opacity(0.2), radius: 10)
            }
            .contentShape(.capsule)
    }
}

#Preview {
    ButtonView()
        .preferredColorScheme(.dark)
}
