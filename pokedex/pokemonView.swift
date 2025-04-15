import SwiftUI

struct pokemonView: View {
    var body: some View {
        VStack {
            Text("#0130")
                .foregroundStyle(.white.opacity(0.95))
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.bottom], 20)
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 200, height: 190)
                    .foregroundStyle(.purple.opacity(0.8))
                    .blur(radius: 55.0)
                Image("gengar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            }
            Text("Gengar")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Text("Ghost")
                Text("/")
                Text("Poison")
            }
            .foregroundStyle(.gray)
            .font(.title3)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.black.opacity(0.95)
                    .ignoresSafeArea()
        }
    }
}

#Preview {
    pokemonView()
}
