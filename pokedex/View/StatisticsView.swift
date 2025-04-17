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

                RoundedGauge(currentValue: Double(self.pokedex.capturedCount))
                    .frame(height: geometry.size.height * 0.30)

                if pokedex.capturedCount > 0 {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(self.pokedex.currentStats) { stat in
                                PlainGauge(type: stat.type, currentValue: stat.representation)
                            }
                        }
                        .padding(.bottom, 90)
                        .safeAreaPadding()
                    }
                    .frame(height: geometry.size.height * 0.7)
                } else {
                    Text("Nenhum Pokémon capturado ainda.")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.top, 32)
                }
            }
        }
        .onAppear {
            pokedex.updateStats()  // Garantir que as estatísticas sejam calculadas quando a view aparecer
        }
        .onChange(of: pokedex.myPokedex) { _ in
            pokedex.updateStats()  // Recalcular apenas quando o Pokedex mudar
        }
    }
}

#Preview {
    StatisticsView(pokedex: Pokedex())
}
