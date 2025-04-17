import SwiftUI

struct ContentView: View {
    @StateObject var pokedex = Pokedex()
    
    var body: some View {
        TabView {
            PokedexView(pokedex: pokedex)
                .tabItem {
                    Label("Pokedex", systemImage: "globe")
                }
            StatisticsView(pokedex: pokedex)
                .id(pokedex.capturedCount)
                .tabItem {
                    Label("Statistics", systemImage: "chart.pie")
                }
        }.tint(.red)
    }
}

#Preview {
    ContentView()
}
