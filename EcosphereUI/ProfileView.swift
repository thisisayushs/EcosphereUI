//
//  ProfileView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 02/28/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var store = CarbonFootprintStore.shared
    @State private var animatedProgress: Double = 0
    @State private var navPath = NavigationPath()
    
    private enum ProfileNavDestination: Hashable {
        case workInProgress
        case questions
    }
    
    private var currentFootprint: Double { store.latestFootprint }
    private var goalFootprint: Double { 4.0 }
    private var progressToGoal: Double {
        // 1.0 when current <= goal, otherwise proportionally less
        guard goalFootprint > 0 else { return 0 }
        let ratio = goalFootprint / max(currentFootprint, goalFootprint)
        return min(max(ratio, 0), 1)
    }
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                BackgroundView(opacity: 0.5)
                
                VStack(spacing: 30) {
                    
                    ZStack {
                        CircularProgressIndicator(progress: animatedProgress)
                            .frame(width: 100, height: 100)
                        
                        Image("Profilemoji")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                    .padding(.bottom)
                    
                    HStack(spacing: 45) {
                        DataCard(
                            valueText: String(format: "%.2f", currentFootprint),
                            subtitleText: "Your current footprint"
                        )
                        DataCard(
                            valueText: String(format: "%.2f", goalFootprint),
                            subtitleText: "Your target footprint"
                        )
                    }
                    
                    VStack(spacing: 15) {
                        ProfileListItem(icon: "person", text: "My Profile") {
                            navPath.append(ProfileNavDestination.workInProgress)
                        }
                        ProfileListItem(icon: "leaf", text: "My Impact Goals") {
                            navPath.append(ProfileNavDestination.workInProgress)
                        }
                        ProfileListItem(icon: "chart.dots.scatter", text: "Progress History") {
                            navPath.append(ProfileNavDestination.workInProgress)
                        }
                        ProfileListItem(icon: "gear", text: "Settings") {
                            navPath.append(ProfileNavDestination.workInProgress)
                        }
                        ProfileListItem(icon: "arrow.counterclockwise", text: "Retake Questionnaire") {
                            store.latestFootprint = 0
                            navPath = NavigationPath([ProfileNavDestination.questions])
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                }
                .onAppear {
                    animatedProgress = 0
                    withAnimation(.easeOut(duration: 1.0)) {
                        animatedProgress = progressToGoal
                    }
                }
                .onChange(of: progressToGoal) { _, newValue in
                    withAnimation(.easeOut(duration: 1.0)) {
                        animatedProgress = newValue
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
            }
            .navigationDestination(for: ProfileNavDestination.self) { destination in
                switch destination {
                case .workInProgress:
                    WorkInProgressView()
                case .questions:
                    QuestionsView()
                }
            }
        }
    }
}

struct ProfileListItem: View {
    var icon: String
    var text: String
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.white)
                    .font(.title2)
                Text(text)
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding()
            .background {
                TransparentBlurView(removeAllFilters: true)
                    .blur(radius: 9, opaque: true)
                    .background(.white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            .frame(height: 60)
        }
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
