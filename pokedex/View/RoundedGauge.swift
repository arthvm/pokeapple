import SwiftUI

struct RoundedGauge: View {
    var currentValue: Double
    @State var showValue: Double = 0.0
    @State private var minValue = 0.0
    @State private var maxValue = 151.0
    
    var body: some View {
        Gauge(value: Double(showValue), in: minValue...maxValue) {
            Text("\(Int(maxValue))")
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
        }currentValueLabel: {
            Text("\(Int(showValue))")
                .contentTransition(.numericText())
        }
        .gaugeStyle(.accessoryCircular)
        .tint(Gradient(stops: [.init(color: .black, location: 0), .init(color: .white, location: 0.1), .init(color: .red, location: 0.5)]))
        .scaleEffect(2.3)
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
    RoundedGauge(currentValue: 12.0)
}
