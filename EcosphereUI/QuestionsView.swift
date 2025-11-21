//
//  QuestionsView.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 02/26/25.
//

import SwiftUI

struct QuestionsView: View {
    @State private var currentQuestion = 0
    private let questions = Question.allQuestions
    @State private var questionnaireComplete = false
    @State private var selectedWeights: [Double] = []
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    // Map average household baseline to 10 tCO2e and scale by mean weight
    private var estimatedTCO2E: Double {
        guard !selectedWeights.isEmpty else { return 0 }
        let meanWeight = selectedWeights.reduce(0, +) / Double(selectedWeights.count)
        let baseline = 10.0
        return (baseline * meanWeight).rounded()
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            if questionnaireComplete {
                HomeView(footprint: estimatedTCO2E)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            } else {
                VStack {
                    ProgressBar(percent: progressPercent)
                    
                    Spacer()
                    
                    let isLast = currentQuestion == questions.count - 1
                    QuestionView(
                        question: questions[currentQuestion],
                        didSelectOption: { weight in
                            record(weight: weight)
                            if isLast { completeQuestionnaire() } else { goToNextQuestion() }
                        }
                    )
                    
                    Spacer()
                }
                .padding()
                .transition(.asymmetric(
                    insertion: .move(edge: .leading).combined(with: .opacity),
                    removal: .move(edge: .trailing).combined(with: .opacity)
                ))
            }
        }
        .animation(.easeInOut(duration: 0.5), value: questionnaireComplete)
        .onAppear { hapticImpact.prepare() }
        .onChange(of: questionnaireComplete) { _, newValue in
            if newValue {
                CarbonFootprintStore.shared.latestFootprint = estimatedTCO2E
            }
        }
    }
    
    // Computed progress from current index and count
    private var progressPercent: CGFloat {
        guard !questions.isEmpty else { return 0 }
        return CGFloat(currentQuestion * 100 / max(questions.count, 1))
    }
    
    // Advance to the next question
    private func goToNextQuestion() {
        hapticImpact.impactOccurred()
        withAnimation { currentQuestion = min(currentQuestion + 1, questions.count - 1) }
    }
    
    // Complete the questionnaire and move to Home screen
    private func completeQuestionnaire() {
        hapticImpact.impactOccurred()
        withAnimation { questionnaireComplete = true }
    }
    
    private func record(weight: Double) {
        if currentQuestion < selectedWeights.count {
            selectedWeights[currentQuestion] = weight
        } else {
            selectedWeights.append(weight)
        }
    }
}

#Preview {
    QuestionsView()
        .preferredColorScheme(.dark)
}
