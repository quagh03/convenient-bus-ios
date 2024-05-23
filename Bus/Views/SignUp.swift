//
//  SignUp.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct SignUp: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var chooseGender: String = "MALE"
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var birth: Date?
    
    @State private var isSignUpActive = false
//    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var dataHolder: DataHolder
    @State private var selectedGenderIndex = 0
    
    //    @State private var otpCode: String
    
    @State private var errorAlert = false
    @State private var showErrorAlert = false
    @State private var showErrorAlertPass = false
    @State private var showErrorAlertEmail = false
    @State private var errorMessage = ""
    @State private var isSignUpButtonTapped = false
    
    @State private var isSignUpSuccess = false
    
    @State private var isShowing = false
    @State private var showToast = false
    
    @State private var isOTPVerify:Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    
    
    
    var body: some View {
        NavigationView {
            ZStack{
                ZStack{
                    ScrollView{
                        VStack {
                            ReuseableTextField(imageName: "person.fill", placeholder: "Họ" ,txtInput: $lastName, hasError: isSignUpButtonTapped && lastName.isEmpty)
                            ReuseableTextField(imageName: "person.fill", placeholder: "Tên" ,txtInput: $firstName, hasError: isSignUpButtonTapped && firstName.isEmpty)
                            ReuseableTextField(imageName: "person.fill", placeholder: "Tài khoản" ,txtInput: $username, hasError: isSignUpButtonTapped && firstName.isEmpty)
                            ReuseableTextField(imageName: "mail.fill", placeholder: "Email" ,txtInput: $email, hasError: isSignUpButtonTapped && (email.isEmpty || !isValidEmail(email)))
                            ReuseableTextField(imageName: "phone.fill", placeholder: "Điện thoại" ,txtInput: $phone, hasError: isSignUpButtonTapped && phone.isEmpty)
                            GenderField(imageName: "figure.stand", chooseGender: $chooseGender)
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.clear)
                                .frame(height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(isSignUpButtonTapped && birth==nil ? Color.red:Color.black, lineWidth: 1)
                                        .frame(height: 50)
                                )
                                .overlay(
                                    HStack{
                                        Image(systemName: "calendar")
                                        DateTimePickerTextField(placeholder: "Ngày Sinh", date: $birth)
                                    }
                                        .padding(.all)
                                )
                                .padding(.bottom, 12)
                                .padding(.top, 12)
                            ReuseableTextField(imageName: "lock.fill", placeholder: "Mật khẩu" ,txtInput: $password, hasError: isSignUpButtonTapped && (password.isEmpty || !isPasswordValid(password)) )
                            ReuseableTextField(imageName: "lock.fill", placeholder: "Xác nhận mật khẩu" ,txtInput: $confirmPassword, hasError: isSignUpButtonTapped && (confirmPassword.isEmpty || !isPasswordValid(confirmPassword)))
                            
                            //                        NavigationLink(destination: ConfirmOTPMail(), isActive: $isSignUpSuccess) {
                            ReuseableButton(red: 8/255,green: 141/255,blue: 224/255,text: "Đăng ký", width: .infinity,imgName: "", textColor: .white) {
                                isSignUpButtonTapped = true
                                if allFieldsFilled() {
                                    if !isValidEmail(email) {
                                        showToast = true
                                        isShowing = true
                                        showErrorAlertEmail = true
                                        showErrorAlertPass = false
                                    } else if !isPasswordValid(password) {
                                        showToast = true
                                        isShowing = true
                                        showErrorAlertPass = true
                                        showErrorAlertEmail = false
                                    } else {
                                        signUp()
                                    }
                                } else {
                                    showToast = true
                                    isShowing = true
                                    showErrorAlert = true
                                }
                            }.padding(.top, 10)
                            //                        }
                            
                        }
                        
                    }
                    .padding(.all)
                    
                }
                
                
                ZStack{
                    if(showErrorAlert && showToast){
                        ToastM(symbol: "", tint: .clear, title: "Vui lòng nhập đầy đủ thông tin!")
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                                    withAnimation {
                                        showErrorAlert = false
                                        showToast = false
                                    }
                                }
                            }
                    } else if (showErrorAlertPass && showToast){
                        ToastM(symbol: "", tint: .clear, title: "Mật khẩu phải có ít nhất 8 ký tự!")
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                                    withAnimation {
                                        showErrorAlertPass = false
                                        showToast = false
                                    }
                                }
                            }
                    } else if ( showErrorAlertEmail && showToast){
                        ToastM(symbol: "", tint: .clear, title: "Email không đúng định dạng!")
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                                    withAnimation {
                                        showErrorAlertEmail = false
                                        showToast = false
                                    }
                                }
                            }
                    }
                }
            }
                .navigationBarHidden(true)
        }
        .onAppear{
            if isOTPVerify{
                dismiss()
            }
        }
        .sheet(isPresented: $isSignUpSuccess, content: {
            ConfirmOTPMail(isOTPVerify: $isOTPVerify)
        })
        .navigationTitle("Đăng ký")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(isSignUpSuccess).navigationBarBackButtonHidden(isSignUpSuccess)
    }
    
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    
    func signUp(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: birth!)
        
        guard let url = URL(string: "\(DataHolder.url)/api/v1/users/register") else {return}
        let registrationData: [String: Any] = [
            "first_name": firstName,
            "last_name": lastName,
            "username": username,
            "phone_number": phone,
            "email": email,
            "password_hash": password,
            "retype_password": confirmPassword,
            "gender": chooseGender,
            "dob": dateString
        ]
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: registrationData)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                if httpResponse.statusCode == 200 {
                    print("Đăng ký thành công")
                    isSignUpSuccess = true
                } else {
                    print("Đăng ký không thành công!")
                    isSignUpSuccess = false
                }
            }.resume()
            
        } catch{
            print("Error")
            
        }
    }
    
    
    func navigateToConfirmOTP(){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/mail/sendVerificationEmail") else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let userData: [String: Any] = ["email": email]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userData)
        } catch {
            print("Failed to serialize JSON:", error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200{
                DispatchQueue.main.async {
                    isSignUpSuccess = true
                    print("gui mail thanh cong")
                }
            } else{
                print("Failed to send verification email")
            }
        }.resume()
    }
    
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    func allFieldsFilled() -> Bool {
        return !username.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !phone.isEmpty && birth != nil
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

