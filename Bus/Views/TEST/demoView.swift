import SwiftUI

struct demo: View {
    @State private var isProcessing: Bool = false
    @State private var paymentSuccess: Bool = false
    
    var body: some View {
        VStack {
            if isProcessing {
                ProgressView("Processing...")
                    .padding()
                    .onAppear {
                        // Simulate payment processing
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isProcessing = false
                            self.paymentSuccess = true
                        }
                    }
            } else if paymentSuccess {
                Image(systemName: "checkmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()
                Text("Payment Successful!")
                    .padding()
            } else {
                Button("Pay") {
                    // Call your payment function here
                    self.isProcessing = true
                }
                .padding()
            }
        }
    }
}

struct demo_Previews: PreviewProvider {
    static var previews: some View {
        demo()
    }
}
