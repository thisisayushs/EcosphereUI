//
//  IllustrativeHomeView.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 03/02/25.
//

import SwiftUI
import SceneKit

struct IllustrativeSceneKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene(named: "Earth.usdz")
        
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
}

struct IllustrativeHomeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var currentPage = 0
    let footprint: Double
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if colorScheme == .dark {
                    DarkBackground()
                } else {
                    LightBackground()
                }
                
                TabView(selection: $currentPage) {
                    // First page
                    VStack {
                        VStack(spacing: 0) {
                            Text("Your carbon footprint score")
                                .padding(.top, 20)
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 20, design: .rounded))
                            HStack(alignment: .firstTextBaseline, spacing: 8) {
                                Text("\(footprint, specifier: "%.2f")")
                                    .font(.system(size: 80, weight: .bold, design: .rounded))
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.green, .white.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                                
                                Text("tCO₂e")
                                    .italic()
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.9))
                            }
                        }
                        
                        IllustrativeSceneKitView()
                            .frame(width: 400)
                            .scaleEffect(1.7)
                            .padding(.bottom, 100)
                        
                        Button(action: {
                            showAlert = true
                        }) {
                            IllustrativeButtonView(content: "Share your world")
                        }
                        .padding(.bottom, 100)
                    }
                    .tag(0)
                    
                    // Second page
                    ScrollView {
                        VStack(spacing: 20) {
                            CardView(title: "5.5 lbs CO₂/day", description: "Biking just twice a week could reduce your emissions, equivalent to planting 10 trees.", icon: "bicycle")
                            
                            CardView(title: "3.2 lbs CO₂/day", description: "Using public transport can significantly reduce your carbon footprint.", icon: "bus")
                            
                            CardView(title: "2.8 lbs CO₂/day", description: "Walking short distances instead of driving helps protect our environment.", icon: "figure.walk")
                        }
                        .padding(.vertical)
                    }
                    
                    .tag(1)
                }
                
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
            }
            .alert("This functionality is yet to be implemented.", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "person.fill")
                    }
                }
            }
        }
    }
}



#Preview {
    IllustrativeHomeView(footprint: 7.25)
    
}


extension IllustrativeHomeView {
    init() {
        self.footprint = CarbonFootprintStore.shared.latestFootprint
    }
}
