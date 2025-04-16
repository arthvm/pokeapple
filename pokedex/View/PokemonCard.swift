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
            HStack {
                VStack(alignment: .leading) {
                    ForEach(pokemon.types, id: \.self) {type in
                        TypeLabel(type: type)
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(getColorFromType(type: pokemon.types[0]).opacity(0.8))
                        .blur(radius: 55)
                    AsyncImage(url: URL(string: pokemonWithData?.data.sprites.front_default ?? "")) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .onAppear() {
                        Task {
                            await getData(pokemon: pokemon)
                        }
                    }
                    .frame(width: 90)
                }
            }
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
