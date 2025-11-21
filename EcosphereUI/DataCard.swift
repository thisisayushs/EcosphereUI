//
//  DataCard.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 02/27/25.
//

import SwiftUI

struct DataCard: View {
    let valueText: String
    let subtitleText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(valueText)
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            
            Text(subtitleText)
                .font(.caption)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
        }
        .padding()
        .foregroundStyle(.white)
        .background {
            TransparentBlurView(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .frame(width: 175, height: 80)
        }
    }
}

#Preview {
    DataCard(valueText: "32.7", subtitleText: "Some sort of text")
        .preferredColorScheme(.dark)
}
