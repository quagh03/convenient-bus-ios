//
//  AlertPayment.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 17/04/2024.
//

import SwiftUI

struct AlertPaymentSuccess: View {
    @EnvironmentObject var dataHolder: DataHolder
    @State var isPress: Bool = true
    @StateObject var circleParameters = CircleCheckmarkParameters()
    @State private var isProcessing: Bool = false
    @State private var paymentSuccess: Bool = false
    @State private var shouldAnimate = false
    @State private var showBtn:Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var isReturn:Bool
    
    var body: some View {
        ZStack{
            //
            ZStack{
//                ProgressView()
//                    .padding()
//                    .opacity(isPress ? 1 : 0)
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            self.paymentSuccess = true
//                            self.isPress = false
//                            self.isProcessing = true
//                        }
//                    }
//                    .offset(y:50)
//                if paymentSuccess{
                    CustomCircleCheckmark(parameters: circleParameters)
                        .onAppear {
                            // Cập nhật tham số khi hiển thị CustomCircleCheckmark
                            circleParameters.updateParameters()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
//                                circleParameters.initialValues()
                                isPress = false
                                self.shouldAnimate = true
                                self.showBtn = true
                                self.isProcessing = true
                            }
                        }
                    //                        .scaleEffect(shouldAnimate ? 0.5 : 1) // Scale down to 50% after a delay
                    //                        .offset(x: shouldAnimate ? -UIScreen.main.bounds.width / 2 + 50 : 0, y: shouldAnimate ? -UIScreen.main.bounds.height / 2 + 100 : 0) // Move to top left corner after a delay
//                        .animation(.spring())
//                }
            }.offset(y: -50)
            //
            if isProcessing {
                Text("Thanh toán thành công !").padding(.vertical).font(.system(size: 23)).offset(y: 40)
            }
            
            VStack{
                Spacer()
                if showBtn{
                    ReuseableButton(red: 52/255, green: 188/255, blue: 88/255, text: "Xác nhận", width: .infinity, imgName: "", textColor: .white) {
                        dismiss()
                        isReturn = true
                    }
                    .padding(.bottom,15)
                    .padding(.horizontal,20)
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct AlertPayment_Previews: PreviewProvider {
    static var previews: some View {
        AlertPaymentSuccess(isReturn: .constant(false))
    }
}
