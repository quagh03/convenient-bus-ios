import SwiftUI

struct demo2: View {
    @State var isPress: Bool = false
    @StateObject var circleParameters = CircleCheckmarkParameters()
    @State private var isProcessing: Bool = false
    @State private var paymentSuccess: Bool = false
    @State var x: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            VStack{
                Button {
                    isPress = true
                } label: {
                    Text("Press me!!")
                }
            }
            if isPress {
                ZStack{
//                    if isPress{
                        ProgressView("Processing...")
                            .padding()
                            .onAppear {
                                // Simulate payment processing
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    self.isProcessing = false
                                    self.paymentSuccess = true
                                }
                            }
//                    }else
                if paymentSuccess{
                        CustomCircleCheckmark(parameters: circleParameters)
                            .onAppear {
                                // Cập nhật tham số khi hiển thị CustomCircleCheckmark
                                circleParameters.updateParameters()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                                    circleParameters.initialValues()
                                    isPress = false
                                }
                            }
                    }
                }
                
            }
            
        }
    }
}


struct contentdemo2: View{
    @State var isPress: Bool = false
    var body: some View{
        ZStack{
            VStack{
                Button {
                    isPress = true
                } label: {
                    Text("press")
                }
            }
            
            if isPress {
                demo2().onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        isPress = false
                    }
                }
            }
        }
    }
}


struct demo2_Previews: PreviewProvider {
    static var previews: some View {
        demo2()
    }
}
