import SwiftUI

struct PokemonView: View {
    let pokemon: Pokemon
    @ObservedObject var pokedex: Pokedex
    @State var pokemonWithData: PokemonWithData?
    
    func getData(pokemon: Pokemon) async {
        do {
            self.pokemonWithData = try await PokeAPI().getPokemonData(pokemon: pokemon)
        } catch {
            
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(getColorFromType(type: pokemon.types[0]).opacity(0.8))
                        .blur(radius: 55.0)
                        .frame(width: geometry.size.width * 0.50,
                               height: geometry.size.width * 0.47)
                    AsyncImage(url: URL(string: pokemonWithData?.data.sprites.front_default ?? "")) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geometry.size.width * 0.4)
                }
                Text(pokemon.name.capitalized)
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                HStack(spacing: 8) {
                    ForEach(pokemon.types, id: \.self) { type in
                        TypeLabel(type: type)
                    }
                }
                .font(.caption)
                
                if let entry = pokemonWithData?.species.flavor_text_entries.first(where: { $0.language.name == "en" }) {
                    let cleanText = entry.flavor_text
                        .replacingOccurrences(of: "\n", with: " ")
                        .replacingOccurrences(of: "\u{000C}", with: " ")

                    Text(cleanText)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    Text("No description available.")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                Button(action: {
                    self.pokedex.toggleCaptured(pokemon: pokemon)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(self.pokedex.wasCaptured(pokemon: pokemon) ? .blue : .green)
                            .frame(width: geometry.size.width * 0.5, height: 50)
                        Text(self.pokedex.wasCaptured(pokemon: pokemon) ? "Release" : "Capture")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }.task {
            await getData(pokemon: pokemon)
        }
    }
}

struct PokemonTypeTag: View {
    let name: String
    
    var body: some View {
        Text(name)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.3))
            .clipShape(Capsule())
            .foregroundStyle(.white)
    }
}

#Preview {
    PokemonView(pokemon: Pokemon(id: 1, name: "bulbasaur", types: [.grass, .poison]), pokedex: Pokedex())
}
