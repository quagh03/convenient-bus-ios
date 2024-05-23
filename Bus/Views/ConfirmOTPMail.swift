//
//  ConfirmOTPMail.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 19/03/2024.
//
//

import SwiftUI
import Combine

struct ConfirmOTPMail: View {
    @State private var otp: [String] = Array(repeating: "", count: 6)
    @State private var currentTextField = 0
    
    @FocusState private var fieldFocus:Int?
    
    @Binding var isOTPVerify: Bool
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataHolder: DataHolder
    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    Text("OTP đã được gửi đến email của bạn!")
                    HStack(spacing: 20) {
                        ForEach(0..<6, id: \.self) { index in
                            TextField("", text: $otp[index])
                                .keyboardType(.numberPad)
                                .frame(width: 40, height: 40)
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .textFieldStyle(PlainTextFieldStyle())
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .padding(.top, 40)
                                        .foregroundColor(.blue)
                                )
                                .focused($fieldFocus, equals: index)
                                .tag(index)
                                .onChange(of: otp[index]) { newValue in
                                    if !newValue.isEmpty{
                                        if index == 5{
                                            fieldFocus = nil
                                        }else {
                                            fieldFocus = (fieldFocus ?? 0) + 1
                                        }
                                    }else{
                                        fieldFocus = (fieldFocus ?? 0) - 1
                                    }
                                }
                        }
                    }
                    .padding()
                    
                    ReuseableButton(red: 8/255, green: 141/255, blue: 224/255, text: "Xác nhận", width: .infinity, imgName: "", textColor: .white) {
                        verifyOTP()
                    }.padding(.all)
                    
                    
                    NavigationLink(destination: Login().navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $isOTPVerify) {
                        EmptyView()
                    }.isDetailLink(false)
                        .hidden()
                    
                    Spacer()
                    
                }.padding(.vertical)
            }
            
            ZStack{
                if !isOTPVerify {
                    ToastM(tint: .clear, title: "Mã OTP không chính xác. Xin vui lòng nhập lại")
                }
            }
            
        }
        .navigationTitle("Xác nhận OTP").navigationBarTitleDisplayMode(.inline).ignoresSafeArea().navigationBarBackButtonHidden(true).navigationBarHidden(isOTPVerify)
    }
    
    //    private func otpTextField(_ index: Int) -> some View {
    //        TextField("", text: Binding(
    //            get: { self.otp[index] },
    //            set: {
    //                self.otp[index] = String($0.prefix(1).filter { $0.isNumber })
    //                if $0.count > 0 && index < 5 {
    //                    self.fieldFocus = index + 1
    //                } else if $0.count == 0 && index > 0 {
    //                    self.fieldFocus = index - 1
    //                }
    //            }
    //        ))
    //        .frame(width: 40, height: 40)
    //        .multilineTextAlignment(.center)
    //        .font(.title)
    //        .textFieldStyle(PlainTextFieldStyle())
    //        .textContentType(.oneTimeCode)
    //        .foregroundColor(.black)
    //        .tag(index)
    //        .focused($fieldFocus, equals: index)
    //        .overlay(
    //            Rectangle()
    //                .frame(height: 1)
    //                .padding(.top, 40)
    //                .foregroundColor(.blue)
    //        )
    //    }
    
    func verifyOTP(){
                let enteredOtp = otp.joined()
        
        guard let url = URL(string: "\(DataHolder.url)/api/v1/users/verify?code=\(enteredOtp)") else {
                    print("Invalid url")
                    return
                }
        
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
        
        
        
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        print("Invalid response")
                        return
                    }
        
                    if httpResponse.statusCode == 200 {
                        print("success!!")
                        isOTPVerify = true
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("error")
//                        isOTPVerify = false
                    }
                }.resume()
    }
    
    
    
}

struct ConfirmOTPMail_Preview: PreviewProvider {
    static var previews: some View {
        ConfirmOTPMail(isOTPVerify: .constant(false))
    }
}
