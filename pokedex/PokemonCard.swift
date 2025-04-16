import SwiftUI

struct PokemonCard: View {
    var pokemon: Pokemon!
    
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
                                    .foregroundStyle(.green.opacity(0.8))
                                    .blur(radius: 55)
                                Image("bulbasaur")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.top], 20)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.green.opacity(0.2), lineWidth: 1)
                    ).preferredColorScheme(.dark)
                }
            }

struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
    PokemonCard(pokemon: Pokemon(id: 5, name: "Bulbasaur", types: [.grass, .poison]))
    }
}
