//
//  WorkInProgressView.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 02/28/25.
//

import SwiftUI

struct WorkInProgressView: View {
    var body: some View {
        ZStack {
            BackgroundView(opacity: 0.5)
            Text("Nothing to see here yet!")
                .italic()
                .font(.title3)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    WorkInProgressView()
        .preferredColorScheme(.dark)
}
