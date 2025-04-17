import SwiftUI

struct RoundedGauge: View {
    @State var currentValue: Double
     
    @State private var minValue = 0.0
    @State private var maxValue = 151.0
    
    var body: some View {
        Gauge(value: currentValue, in: minValue...maxValue) {
            Text("\(Int(maxValue))")
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
        }currentValueLabel: {
            Text("\(Int(currentValue))")
                .contentTransition(.numericText())
        }
        .gaugeStyle(.accessoryCircular)
        .tint(Gradient(stops: [.init(color: .black, location: 0), .init(color: .white, location: 0.1), .init(color: .red, location: 0.5)]))
        .scaleEffect(2.3)
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
    RoundedGauge(currentValue: 115.0)
}
