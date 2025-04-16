import SwiftUI

struct PokemonView: View {
    let id: Int
    let blurColor: Color
    let imageName: String
    let pokemonName: String
    let typeTags: [String]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("#\(id)")
                    .foregroundStyle(.white.opacity(0.95))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding([.bottom], 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(blurColor.opacity(0.8))
                        .blur(radius: 55.0)
                        .frame(width: geometry.size.width * 0.50,
                               height: geometry.size.width * 0.47)
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.4)
                }
                Text(pokemonName)
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                HStack(spacing: 8) {
                    ForEach(typeTags, id: \.self) { type in
                        PokemonTypeTag(name: type)
                    }
                }
                .font(.caption)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.95).ignoresSafeArea())
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
    PokemonView(id: 130, blurColor: .purple, imageName: "gengar", pokemonName: "Gengar", typeTags: ["Ghost", "Poison", "Gui", "Fodinha"])
}
