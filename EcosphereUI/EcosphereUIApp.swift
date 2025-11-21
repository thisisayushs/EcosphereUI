//
//  EcosphereUIApp.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 02/26/25.
//

import SwiftUI

@main
struct EcosphereUIApp: App {
    var body: some Scene {
        WindowGroup {
            QuestionsView()
                .preferredColorScheme(.dark)
        }
    }
}
