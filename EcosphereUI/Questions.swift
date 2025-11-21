//
//  Questions.swift
//  EcosphereUI
//
//  Created by Ayush Kumar Singh on 02/26/25.
//

import SwiftUI

// MARK: - Model
struct QuestionOption: Hashable {
    let title: String
    // Lower weight means more sustainable (lower emissions)
    let weight: Double
}

struct Question: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let subtitle: String
    let options: [QuestionOption]
}

// MARK: - Reusable View
struct QuestionView: View {
    let question: Question
    // Return the selected option's weight to the parent
    var didSelectOption: (Double) -> Void

    var body: some View {
        VStack {
            Spacer()

            VStack {
                Text(question.title)
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)

                Text(question.subtitle)
                    .fontWeight(.light)
                    .italic()
                    .foregroundStyle(.white)
                    .font(.body)
                    .padding(.top, 5)
            }
            .multilineTextAlignment(.center)

            Spacer()

            VStack(spacing: 0) {
                ForEach(question.options, id: \.self) { option in
                    Button(action: { didSelectOption(option.weight) }) {
                        ButtonView(content: option.title)
                    }
                    .padding()
                }
            }
            .tint(.white)
        }
    }
}

// MARK: - Questions Store
extension Question {
    static var allQuestions: [Question] {
        [
            Question(
                title: "How do you get around?",
                subtitle: "From morning commutes to daily adventures, the way you move shapes the world.",
                options: [
                    QuestionOption(title: "I love walking", weight: 0.1),
                    QuestionOption(title: "Public transport is my go to", weight: 0.4),
                    QuestionOption(title: "I usually share ride with others", weight: 0.6),
                    QuestionOption(title: "I drive myself all the time", weight: 1.0)
                ]
            ),
            Question(
                title: "What best describes your diet?",
                subtitle: "Your food choices have a significant impact on carbon emissions from production to transportation.",
                options: [
                    QuestionOption(title: "Plant-based/Vegan", weight: 0.1),
                    QuestionOption(title: "Vegetarian", weight: 0.3),
                    QuestionOption(title: "Flexitarian (occasional meat)", weight: 0.6),
                    QuestionOption(title: "Regular meat consumption", weight: 1.0)
                ]
            ),
            Question(
                title: "How energy efficient is your home?",
                subtitle: "Home energy use contributes significantly to your carbon footprint.",
                options: [
                    QuestionOption(title: "Highly efficient (renewable energy)", weight: 0.2),
                    QuestionOption(title: "Moderately efficient", weight: 0.5),
                    QuestionOption(title: "Standard efficiency", weight: 0.8),
                    QuestionOption(title: "Not very efficient", weight: 1.0)
                ]
            ),
            Question(
                title: "How would you describe your shopping habits?",
                subtitle: "Consumer choices impact production, packaging, and shipping emissions.",
                options: [
                    QuestionOption(title: "Minimal, only essentials", weight: 0.2),
                    QuestionOption(title: "Moderate, secondhand when possible", weight: 0.4),
                    QuestionOption(title: "Regular shopping, some new items", weight: 0.7),
                    QuestionOption(title: "Frequent new purchases", weight: 1.0)
                ]
            ),
            Question(
                title: "How do you manage waste?",
                subtitle: "Waste management affects methane emissions and resource conservation.",
                options: [
                    QuestionOption(title: "Zero-waste lifestyle", weight: 0.2),
                    QuestionOption(title: "Comprehensive recycling and composting", weight: 0.4),
                    QuestionOption(title: "Basic recycling", weight: 0.7),
                    QuestionOption(title: "Minimal recycling effort", weight: 1.0)
                ]
            )
        ]
    }
}

// MARK: - Previews
#Preview("Single Question Preview") {
    QuestionView(
        question: Question(
            title: "Preview Title",
            subtitle: "Preview subtitle goes here.",
            options: [
                QuestionOption(title: "One", weight: 0.25),
                QuestionOption(title: "Two", weight: 0.5),
                QuestionOption(title: "Three", weight: 0.75),
                QuestionOption(title: "Four", weight: 1.0)
            ]
        ),
        didSelectOption: { _ in }
    )
    .preferredColorScheme(.dark)
}
