//
//  AlertPayment.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 17/04/2024.
//

import SwiftUI

struct AlertPaymentFailed: View {
    @State var isPress: Bool = true
    @StateObject var circleParameters = CircleCheckmarkParameters()
    @State private var isProcessing: Bool = false
    @State private var paymentSuccess: Bool = false
    @State private var shouldAnimate = false
    @State private var showBtn:Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            //
            ZStack{
                ProgressView()
                    .padding()
                    .opacity(isPress ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.paymentSuccess = true
                            self.isPress = false
                            self.isProcessing = true
                        }
                    }
                if paymentSuccess{
                    CustomCircleFailed(parameters: circleParameters)
                        .onAppear {
                            // Cập nhật tham số khi hiển thị CustomCircleCheckmark
                            circleParameters.updateParameters()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
//                                circleParameters.initialValues()
                                isPress = false
                                self.shouldAnimate = true
                                self.showBtn = true
//                                self.isProcessing = true
                            }
                        }
                    //                        .scaleEffect(shouldAnimate ? 0.5 : 1) // Scale down to 50% after a delay
                    //                        .offset(x: shouldAnimate ? -UIScreen.main.bounds.width / 2 + 50 : 0, y: shouldAnimate ? -UIScreen.main.bounds.height / 2 + 100 : 0) // Move to top left corner after a delay
//                        .animation(.spring())
                }
            }
            //
            if isProcessing {
                Text("Thanh toán thất bại !").padding(.vertical).font(.system(size: 23)).offset(y: 90)
            }
            
            VStack{
                Spacer()
                if showBtn{
                    ReuseableButton(red: 255/255, green: 59/255, blue: 47/255, text: "Quay lại", width: .infinity, imgName: "", textColor: .white) {
                        dismiss()
                    }
                    .padding(.bottom,15)
                    .padding(.horizontal,20)
                }
            }

        }.background(.clear)
    }
}

struct AlertPaymentFailed_Previews: PreviewProvider {
    static var previews: some View {
        AlertPaymentFailed()
    }
}
