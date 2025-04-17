import SwiftUI

struct StatisticsView: View {
    @State var currentStats: [TypeStat] = []
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Statistics")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .safeAreaPadding()
                RoundedGauge(currentValue: 69)
                    .frame(height: geometry.size.height * 0.30)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(currentStats) { stat in
                            PlainGauge(type: stat.type, currentValue: stat.representation)
                        }
                    }
                    .padding(.bottom, 90)
                    .safeAreaPadding()
                }
                .frame(height: geometry.size.height * 0.7)
            }
        }
        .task {
            currentStats = getTypeStats(allPokemons: pokemonsData, capturedPokemons: randomPokemons)
        }
    }
}

#Preview {
    StatisticsView()
}
