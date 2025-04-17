import SwiftUI

struct PlainGauge: View {
    var type: ElementType
    @State var currentValue: Double
    @State var minValue: Double = 0
    @State var maxValue: Double = 100
    
    var body: some View {
        HStack(spacing: 24) {
            Text("\(type.rawValue.capitalized)")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .frame(width: 80, alignment: .leading)

            HStack(spacing: 5) {
                Text("\(Int(currentValue))")
                    .contentTransition(.numericText())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(getColorFromType(type: type))
                    .frame(width: 40, alignment: .trailing)
                Text("%")
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
            }
            
            Gauge(value: currentValue, in: minValue...maxValue) {}
                .tint(Gradient(colors: [
                    getColorFromType(type: type).opacity(0.55),
                    getColorFromType(type: type)
                ]))
        }
        .preferredColorScheme(.dark)
        .onAppear {
            let targetValue = currentValue
            currentValue = 0
            Task {
                for i in 0...100 {
                    withAnimation(.spring) {
                        currentValue = Double(i) / 100 * targetValue
                    }
                    try await Task.sleep(for: .milliseconds(10))
                }
            }
        }
    }
}

#Preview {
    PlainGauge(type: .ice, currentValue: 69, minValue: 0, maxValue: 100)
}
