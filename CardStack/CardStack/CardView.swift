//
//  CardView.swift
//  CardStack
//
//  Created by ronik on 12/25/23.
//

import SwiftUI

struct Card: Identifiable {
    var id: Int
    var gradientColors: [Color]
    var offsetX: CGFloat = 0
    var rotation: Double = 0
}

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(
                    gradient: Gradient(colors: card.gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [Color.white.opacity(0.5), Color.clear, Color.white.opacity(0.5)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ), lineWidth: 10)
                )
                .rotation3DEffect(
                    .degrees(card.rotation),
                    axis: (x: 0, y: 1, z: 0) // Rotate around the y-axis
                )
        }
    }
}
