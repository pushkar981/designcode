import SwiftUI

struct ContentView: View {
    var body: some View {
        GalaxySunflowerView()
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GalaxySunflowerView: View {
    @State private var isGalaxy = false
    private let seedCount = 300
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<seedCount, id: \.self) { index in
                    Circle()
                        .fill(self.randomColor())
                        .frame(width: self.circleSize(index: index, rect: geometry.size), height: self.circleSize(index: index, rect: geometry.size))
                        .position(self.isGalaxy ? self.galaxyCirclePosition(index: index, rect: geometry.size) : self.sunflowerCirclePosition(index: index, rect: geometry.size))
                        .animation(self.springAnimation, value: isGalaxy)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onTapGesture {
                self.isGalaxy.toggle()
            }
        }
    }
    
    private var springAnimation: Animation {
        Animation.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)
    }
    
    private func randomColor() -> Color {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
        return colors.randomElement() ?? .black
    }
    
    private func sunflowerCirclePosition(index: Int, rect: CGSize) -> CGPoint {
        let angleIncrement = 2 * Double.pi * (1.0 - (1.0 / Constants.goldenRatio))
        let maxRadius = min(rect.width, rect.height) * 0.5
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        
        let radius = sqrt(Double(index)) * maxRadius / sqrt(Double(seedCount))
        let angle = Double(index) * angleIncrement
        let x = center.x + CGFloat(radius * cos(angle))
        let y = center.y + CGFloat(radius * sin(angle))
        
        return CGPoint(x: x, y: y)
    }
    
    private func galaxyCirclePosition(index: Int, rect: CGSize) -> CGPoint {
        let angleIncrement = 2 * Double.pi / Double(seedCount)
        let maxRadius = max(rect.width, rect.height) * 0.75
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)

        let radius = Double(index) / Double(seedCount) * maxRadius
        // Increase the multiplier for more turns in the spiral
        let angle = Double(index) * angleIncrement * 10
        let x = center.x + CGFloat(radius * cos(angle))
        let y = center.y + CGFloat(radius * sin(angle))

        return CGPoint(x: x, y: y)
    }
    
    private func circleSize(index: Int, rect: CGSize) -> CGFloat {
        let maxRadius = max(rect.width, rect.height) * 0.75 // Adjusted max radius
        let radius = sqrt(Double(index)) * maxRadius / sqrt(Double(seedCount))
        return CGFloat(1.0 - (radius / maxRadius)) * 18 // Increased maximum size
    }
    
    struct Constants {
        static let goldenRatio: Double = 1.61803398875
    }
}
