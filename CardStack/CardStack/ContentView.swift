import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = [
        Card(id: 0, gradientColors: [Color(hex: "#FFFFFF"), Color(hex: "#5D11F7")]),
        Card(id: 1, gradientColors: [Color(hex: "#FFFFFF"), Color(hex: "#FFD700")]),
        Card(id: 2, gradientColors: [Color(hex: "#FFFFFF"), Color(hex: "#20B2AA")])
    ]
    
    var body: some View {
        let cardOffset = -10 
        
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                ZStack {
                    ForEach(cards, id: \.id) { card in
                        CardView(card: card)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                            .offset(x: CGFloat(card.id * cardOffset))
                            .offset(x: card.id == cards.count - 1 ? card.offsetX : 0)
                            .opacity(1.0 - 0.1 * CGFloat(card.id))
                            .gesture(
                                card.id == cards.count - 1 ?
                                DragGesture()
                                    .onChanged { gesture in
                                        if abs(gesture.translation.width) < 150 {
                                            let dragAmount = gesture.translation.width
                                            cards[cards.count - 1].offsetX = dragAmount
                                            cards[cards.count - 1].rotation = Double(dragAmount) / 20
                                        }
                                    }
                                    .onEnded { _ in
                                        if abs(cards[cards.count - 1].offsetX) > 100 {
                                            moveCardToBottom()
                                        } else {
                                            withAnimation {
                                                cards[cards.count - 1].offsetX = 0
                                                cards[cards.count - 1].rotation = 0
                                            }
                                        }
                                    }
                                : nil
                            )
                    }
                }
            }
        }
    }
    
    private func moveCardToBottom() {
        withAnimation {
            var topCard = cards.removeLast()
            topCard.offsetX = 0
            topCard.rotation = 0
            cards.insert(topCard, at: 0)
            for i in 0..<cards.count {
                cards[i].id = i
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
