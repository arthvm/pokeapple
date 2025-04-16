import SwiftUI

struct PokemonView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("#0130")
                    .foregroundStyle(.white.opacity(0.95))
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding([.bottom], 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(.purple.opacity(0.8))
                        .blur(radius: 55.0)
                        .frame(width: geometry.size.width * 0.50,
                               height: geometry.size.width * 0.47)
                    Image("gengar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.4)
                }
                Text("Gengar")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                HStack(spacing: 8) {
                    PokemonTypeTag(name: "Ghost")
                    PokemonTypeTag(name: "Poison")
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
    PokemonView()
}
