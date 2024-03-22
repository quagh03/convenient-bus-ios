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
    
//    @Binding var username: String
//    @Binding var password: String
//    @Binding var firstName: String
//    @Binding var lastName: String
//    @Binding var phone: String
//    @Binding var email: String
//    @Binding var chooseGender: String
//    @Binding var birth: Date?
    
//    @Binding var otpCode: String
    
//    @Binding var isSignUpSuccess: Bool
//    @State private var showToast: Bool = false
    
    
    var body: some View {
        NavigationView{
            VStack {
//                Text("Nhập mã OTP").bold()
                HStack(spacing: 20) {
                    ForEach(0..<6, id: \.self) { index in
                        otpTextField(index)
                            .onReceive(Just(otp[index])) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.otp[index] = filtered
                                }
                                if newValue.count == 1 {
                                    if index < 5 {
                                        self.currentTextField = index + 1
                                    }
                                } else if newValue.isEmpty {
                                    if index > 0 {
                                        self.currentTextField = index - 1
                                    }
                                }
                            }
                            .keyboardType(.numberPad)
                    }
                }
                .padding()
                
                ReuseableButton(red: 8/255, green: 141/255, blue: 224/255, text: "Xác nhận", width: .infinity, imgName: "", textColor: .white) {
                    verifyOTP()
                }.padding(.all)
                
                Spacer()

            }
        }.navigationTitle("Xác nhận OTP").navigationBarTitleDisplayMode(.inline).ignoresSafeArea()
    }
    
    private func otpTextField(_ index: Int) -> some View {
        TextField("", text: Binding(
            get: { self.otp[index] },
            set: {
                self.otp[index] = $0
                if $0.count > 0 && index < 5 {
                    self.currentTextField = index + 1
                } else if $0.count == 0 && index > 0 {
                    self.currentTextField = index - 1
                }
            }
        ))
        .frame(width: 40, height: 40)
        .multilineTextAlignment(.center)
        .font(.title)
        .textFieldStyle(PlainTextFieldStyle())
        .textContentType(.oneTimeCode)
        .foregroundColor(.black)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .padding(.top, 40)
                .foregroundColor(.blue)
        )
    }
    
    func verifyOTP(){
        let enteredOtp = otp.joined()
        
        guard let url = URL(string: "http://localhost:8080/api/v1/users/verify?code=\(enteredOtp)") else {
            print("Invalid url")
            return
        }
//
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("success!!")
            } else {
                print("error")
            }
        }.resume()
    }
    
    
    
}

struct ConfirmOTPMail_Preview: PreviewProvider {
    static var previews: some View {
        ConfirmOTPMail()
    }
}
