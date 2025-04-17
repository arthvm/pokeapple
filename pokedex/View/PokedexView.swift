import SwiftUI

struct PokedexView: View {
    @ObservedObject var pokedex: Pokedex
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.95).ignoresSafeArea()
            NavigationStack {
                ZStack {
                    List {
                        ForEach(searchText == "" ? self.pokedex.allPokemons : self.pokedex.allPokemons.filter {
                            $0.name.contains(searchText.lowercased())
                        }) { pokemon in
                            ScrollView {
                                NavigationLink(destination: {
                                    PokemonView(pokemon: pokemon, pokedex: self.pokedex)
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
                    .searchable(text: $searchText).listStyle(.plain)
                }
                .navigationTitle("Pokedex")
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    PokedexView(pokedex: Pokedex())
}
