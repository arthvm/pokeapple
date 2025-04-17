import SwiftUI

struct ContentView: View {
    @State var pokemons = [Pokemon]()
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.95).ignoresSafeArea()
            NavigationStack {
                ZStack {
                    List {
                        ForEach(searchText == "" ? pokemons : pokemons.filter {
                            $0.name.contains(searchText.lowercased())
                        }) { pokemon in
                            ScrollView {
                                NavigationLink(destination: {
                                    PokemonView(pokemon: pokemon)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .toolbar {
                                            ToolbarItem(placement: .principal) {
                                                Text("#\(pokemon.id)")
                                                    .foregroundStyle(.white.opacity(0.95))
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                            }
                                        }
                                })
                                {
                                    PokemonCard(pokemon: pokemon)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .onAppear {
                        pokemons = pokemonsData
                    }
                    .searchable(text: $searchText).listStyle(.plain)
                }
                .navigationTitle("Pokedex")
            }
            
        }
        .preferredColorScheme(.dark)
    }
    
}

#Preview {
    ContentView()
}
