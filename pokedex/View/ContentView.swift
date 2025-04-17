import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PokedexView()
                .tabItem {
                    Label("Pokedex", systemImage: "globe")
                }
            StatisticsView()
                .tabItem {
                    Label("Statistics", systemImage: "chart.pie")
                }
        }.tint(.red)
    }
}

#Preview {
    ContentView()
}
