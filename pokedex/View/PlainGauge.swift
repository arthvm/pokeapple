import SwiftUI

struct PlainGauge: View {
    var type: ElementType
    var currentValue: Double
    @State var minValue: Double = 0
    @State var maxValue: Double = 100
    @State var showValue: Double = 0
    
    
    var body: some View {
        HStack(spacing: 24) {
            Text("\(type.rawValue.capitalized)")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .frame(width: 80, alignment: .leading)

            HStack(spacing: 5) {
                Text("\(Int(showValue))")
                    .contentTransition(.numericText())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(getColorFromType(type: type))
                    .frame(width: 40, alignment: .trailing)
                Text("%")
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
            }
            
            Gauge(value: Double(showValue), in: minValue...maxValue) {}
                .tint(Gradient(colors: [
                    getColorFromType(type: type).opacity(0.55),
                    getColorFromType(type: type)
                ]))
        }
        .preferredColorScheme(.dark)
        .onAppear {
            showValue = 0
            Task {
                for i in 0...100 {
                    withAnimation(.spring) {
                        showValue = Double(i) / 100 * currentValue
                    }
                    try await Task.sleep(for: .milliseconds(10))
                }
            }
        }
    }
}

#Preview {
    PlainGauge(type: .ice, currentValue: 69.0, minValue: 0, maxValue: 100)
}
