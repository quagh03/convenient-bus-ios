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
    
    @ObservedObject var userAPI = UserAPI()
    
    @State private var errorAlert = false
    @State private var showErrorAlert = false
    @State private var showErrorAlertPass = false
    @State private var showErrorAlertEmail = false
    @State private var showErrorAlertUsername = false
    @State private var showErrorAlertEmailExist = false
    @State private var showErrorAlertPhoneExist = false
    @State private var showErrorAlertPasswordMatch = false
    
    @State private var errorMessage = ""
    @State private var isSignUpButtonTapped = false
    
    @State private var isSignUpSuccess = false
    
    @State private var isShowing = false
    @State private var showToast = false
    
    @State private var isOTPVerify:Bool = false
    @State private var isSignUpLoad:Bool = false
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
                            ReuseableButton(red: isSignUpLoad ? 211/255 : 8/255,green: isSignUpLoad ? 211/255 : 141/255,blue: isSignUpLoad ? 211/255 : 224/255,text: isSignUpLoad ? "Loading..." : "Đăng ký", width: .infinity,imgName: "", textColor: .white) {
                                isSignUpButtonTapped = true
                                isSignUpLoad = true
                                if allFieldsFilled() {
                                    if !isValidEmail(email) {
                                        showAlert(alertType: .invalidEmail)
                                    } else if !isPasswordValid(password) {
                                        showAlert(alertType: .invalidPassword)
                                    } else if !passwordsMatch(){
                                        showAlert(alertType: .showErrorAlertPasswordMatch)
                                    } else if !isOldEnough(birthDate: birth!) {
                                        showAlert(alertType: .other(message: "Người dùng phải lớn hơn 6 tuổi!"))
                                    } else {
                                        checkDuplicateInformation()
                                    }
                                } else {
                                    showAlert(alertType: .incompleteFields)
                                }
                            }.padding(.top, 10)
                                .disabled(isSignUpLoad)
                            //                        }
                            
                        }
                        
                    }
                    .padding(.all)
                    
                }
                
                
                ZStack{
                    if showToast {
                        ToastM(symbol: "", tint: .clear, title: errorMessage)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        resetAlertStates()
                                    }
                                }
                            }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear{
//            userAPI.getAllUser()
        }
        .sheet(isPresented: $isSignUpSuccess, onDismiss: {
            if isOTPVerify{
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            ConfirmOTPMail(isOTPVerify: $isOTPVerify)
        }
        //        .sheet(isPresented: $isSignUpSuccess, content: {
        //            ConfirmOTPMail(isOTPVerify: $isOTPVerify)
        //                .onChange(of: isOTPVerify) { newValue in
        //                    if newValue {
        //                        dismiss()
        //                    }
        //                }
        //        })
        .navigationTitle("Đăng ký")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(isSignUpSuccess).navigationBarBackButtonHidden(isSignUpSuccess)
    }
    
    func calculateAge(birthDate: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        let age = ageComponents.year!
        return age
    }

    func isOldEnough(birthDate: Date) -> Bool {
        let age = calculateAge(birthDate: birthDate)
        return age >= 6
    }
    
    func resetAlertStates() {
        showErrorAlert = false
        showErrorAlertPass = false
        showErrorAlertEmail = false
        showErrorAlertUsername = false
        showErrorAlertEmailExist = false
        showErrorAlertPhoneExist = false
        showErrorAlertPasswordMatch = false
        showToast = false
        errorMessage = ""
    }
    enum AlertType {
        case incompleteFields
        case invalidEmail
        case invalidPassword
        case emailExists
        case usernameExists
        case phoneExists
        case showErrorAlertPasswordMatch
        case other(message: String)
    }
    func showAlert(alertType: AlertType) {
        showToast = true
        isShowing = true
        isSignUpLoad = false
        
        switch alertType {
        case .incompleteFields:
            showErrorAlert = true
            errorMessage = "Vui lòng nhập đầy đủ thông tin!"
        case .invalidEmail:
            showErrorAlertEmail = true
            errorMessage = "Email không đúng định dạng!"
        case .invalidPassword:
            showErrorAlertPass = true
            errorMessage = "Mật khẩu phải có ít nhất 8 ký tự!"
        case .emailExists:
            showErrorAlertEmailExist = true
            errorMessage = "Người dùng đã tồn tại, Vui lòng kiểm tra lại email, username hoặc số điện thoại!"
        case .usernameExists:
            showErrorAlertUsername = true
            errorMessage = "Username đã tồn tại!"
        case .phoneExists:
            showErrorAlertPhoneExist = true
            errorMessage = "Số điện thoại đã tồn tại!"
        case .showErrorAlertPasswordMatch:
            showErrorAlertPasswordMatch = true
            errorMessage = "Mật khẩu không khớp!"
        case .other(let message):
            showErrorAlert = true
            errorMessage = message
        }
        print("Alert triggered: \(errorMessage)")
    }
    
    func passwordsMatch() -> Bool {
        return password == confirmPassword
    }

    
    func checkDuplicateInformation() {
//        let emailExists = userAPI.allUser.contains { $0.email == email }
//        let usernameExists = userAPI.allUser.contains { $0.username == username }
//        let phoneExists = userAPI.allUser.contains { $0.phoneNumber == phone }
        
//        if emailExists {
//            showAlert(alertType: .emailExists)
//        } else if usernameExists {
//            showAlert(alertType: .usernameExists)
//        } else if phoneExists {
//            showAlert(alertType: .phoneExists)
//        } else {
            signUp()
//        }
//        if !isSignUpSuccess{
//            showAlert(alertType: <#T##AlertType#>)
//        }
        
        
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
                    isSignUpLoad = false
                } else {
                    print("Đăng ký không thành công!")
//                    isSignUpSuccess = false
//                    isSignUpLoad = false
                    if let data = data {
                        do {
                            if let errorResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let errorCode = errorResponse["code"] as? Int,
                               let errorMessage = errorResponse["message"] as? String {
                                DispatchQueue.main.async {
                                    self.handleSignUpError(errorCode: errorCode, errorMessage: errorMessage)
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.handleSignUpError(errorCode: nil, errorMessage: "Unknown error")
                                }
                            }
                        } catch {
                            DispatchQueue.main.async {
                                self.handleSignUpError(errorCode: nil, errorMessage: "Failed to parse error response")
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.handleSignUpError(errorCode: nil, errorMessage: "No data received")
                        }
                    }
                    DispatchQueue.main.async {
                        self.isSignUpLoad = false
                    }
                }
            }.resume()
            
        } catch{
            print("Error")
            
        }
    }
    
    func handleSignUpError(errorCode: Int?, errorMessage: String) {
        print("Error: \(errorMessage) with code: \(String(describing: errorCode))")
        if let code = errorCode {
            switch code {
            case 3004:
                showAlert(alertType: .emailExists)
            default:
                showAlert(alertType: .other(message: errorMessage))
            }
        } else {
            showAlert(alertType: .other(message: errorMessage))
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

