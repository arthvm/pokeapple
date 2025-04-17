import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PokedexView()
                .tabItem {
                    Label("Pokedex", systemImage: "list.bullet.rectangle")
                }
            
            StatisticsView()
                .tabItem {
                    Label("Statistics", systemImage: "chart.line.uptrend.xyaxis.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
