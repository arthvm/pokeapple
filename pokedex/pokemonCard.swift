import SwiftUI

struct pokemonCard: View {
    var body: some View {
            Grid (horizontalSpacing: 30, verticalSpacing: 30) {
                GridRow {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Bulbasaur")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundStyle(.white)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Grass")
                                    .foregroundStyle(.white)
                                    .fontWeight(.medium)
                                    .padding([.horizontal], 14)
                                    .padding([.vertical], 6)
                                    .background(.white.opacity(0.25))
                                    .cornerRadius(20)
                                Text("Poison")
                                    .foregroundStyle(.white)
                                    .fontWeight(.medium)
                                    .padding([.horizontal], 14)
                                    .padding([.vertical], 6)
                                    .background(.white.opacity(0.25))
                                    .cornerRadius(20)
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
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.black.opacity(0.95)
                    .ignoresSafeArea()
        }
    }
}

struct pokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        pokemonCard()
    }
}
