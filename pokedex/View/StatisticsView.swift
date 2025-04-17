import SwiftUI

struct StatisticsView: View {
    @ObservedObject var pokedex: Pokedex
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Statistics")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .safeAreaPadding()
                
                RoundedGauge(currentValue: Double(pokedex.capturedCount))
                    .frame(height: geometry.size.height * 0.30)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(Array(pokedex.currentStats.enumerated()), id:\.offset) { index, stat in
                            PlainGauge(type: stat.type, currentValue: pokedex.currentStats[index].representation)
                        }
                    }
                    .padding(.bottom, 90)
                    .safeAreaPadding()
                }
                .frame(height: geometry.size.height * 0.7)
            }
        }
    }
}
#Preview {
    StatisticsView(pokedex: Pokedex())
}
