import SwiftUI

struct PokemonCard: View {
    var pokemon: Pokemon
    @State var pokemonWithData: PokemonWithData?
    
    func getData(pokemon: Pokemon) async {
        do {
            self.pokemonWithData = try await PokeAPI().getPokemonData(pokemon: pokemon)
        } catch {
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(pokemon.name.capitalized)
                .fontWeight(.bold)
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.horizontal, 40)
            ZStack {
                GeometryReader { geometry in
                    HStack {
                        if pokemon.types.count > 1 {
                            RoundedRectangle(cornerRadius: 40)
                                .frame(width: 200, height: 100)
                                .foregroundStyle(getColorFromType(type: pokemon.types[1]).opacity(0.4))
                                .blur(radius: 70)
                        }
                        Spacer()
                        RoundedRectangle(cornerRadius: 40)
                            .frame(width: 180, height: 100)
                            .foregroundStyle(getColorFromType(type: pokemon.types[0]).opacity(0.7))
                            .blur(radius: 55)
                    }
                    .frame(width: geometry.size.width)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        ForEach(pokemon.types, id: \.self) { type in
                            TypeLabel(type: type)
                        }
                    }
                    Spacer()
                    AsyncImage(url: URL(string: pokemonWithData?.data.sprites.front_default ?? "")) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .onAppear {
                        Task {
                            await getData(pokemon: pokemon)
                        }
                    }
                    .frame(width: 100)
                }
                .padding(.horizontal, 40)
            }
            .frame(height: 100)
        }
        .frame(maxWidth: .infinity)
        .padding([.top], 20)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(getColorFromType(type: pokemon.types[0]).opacity(0.2), lineWidth: 1)
        ).preferredColorScheme(.dark)
    }
}

struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCard(pokemon: Pokemon(id: 94, name: "gengar", types: [.ghost, .poison]))
    }
}
