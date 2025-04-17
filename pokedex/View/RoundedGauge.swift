import SwiftUI

struct RoundedGauge: View {
    @State var currentValue: Double
     
    @State private var minValue = 0.0
    @State private var maxValue = 151.0
    
    var body: some View {
        Gauge(value: currentValue, in: minValue...maxValue) {
            Text("My Pokemons")
        }currentValueLabel: {
            Text("\(Int(currentValue))")
                .contentTransition(.numericText())
        } minimumValueLabel: {
            Text("\(Int(minValue))")
        } maximumValueLabel: {
            Text("\(Int(maxValue))")
        }
        .gaugeStyle(.accessoryCircular)
        .preferredColorScheme(.dark)
        .scaleEffect(1.6)
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
