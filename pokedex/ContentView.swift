//
//  ContentView.swift
//  pokedex
//
//  Created by Aluno Mack on 15/04/25.
//

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
                            PokemonCard(pokemon: pokemon)
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
