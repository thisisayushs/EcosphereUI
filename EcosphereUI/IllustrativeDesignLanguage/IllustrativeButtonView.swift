//
//  IllustrativeButtonView.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 03/01/25.
//

import SwiftUI

struct IllustrativeButtonView: View {
    var content: String = "Tap"
    var icon: String = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .foregroundStyle(.white)
                .shadow(radius: 1.5)
                .frame(width: 360, height: 60)
            
            HStack {
                Image(systemName: icon)
                Text(content)
            }.foregroundStyle(.black.opacity(0.8))
                .font(.title3)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
        }
    }
}

#Preview {
    IllustrativeButtonView()
        .preferredColorScheme(.light)
}
