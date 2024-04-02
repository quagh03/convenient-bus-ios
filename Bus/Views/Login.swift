//
//  Login.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var isSignUpButtonTapped = false
    @State private var gender: String = ""
    
    @ObservedObject private var userModel = LoginApi()
//    @Published var userLog: user?
    @State private var isLogin: Bool = false
    
//    let busRouteDetail: BusRouteDetail
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("background").resizable().ignoresSafeArea()
                VStack{
                    Image("logoHuce")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                        .padding(.bottom, 50)
                    ReuseableTextField(imageName: "person.fill", placeholder: "Tài khoản" ,txtInput: $username, hasError: isSignUpButtonTapped && username.isEmpty)
                    ReuseableTextField(imageName: "lock.fill", placeholder: "Mật khẩu" ,txtInput: $password, hasError: isSignUpButtonTapped && password.isEmpty)
                    
                    HStack{
                        ReuseableButton(red: 8/255,green: 141/255,blue: 224/255,text: "Đăng nhập", width: 280,imgName: "", textColor: .white) {
                            login(username: username, password: password)
                        }
                        Spacer()
                        Image(systemName: "faceid")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.black)
                    }
                    
                    HStack{
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(height: 1)
                            .padding(.horizontal,10)
                        Text("OR")
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(height: 1)
                            .padding(.horizontal,10)
                    }.padding(.vertical,10)
                    
                    ReuseableButton(red: 255/255, green: 255/255, blue: 255/255, text: "Login with Google", width: .infinity , imgName: "loginwithgg", textColor: .black) {
                        isSignUpButtonTapped = true
                        loginWithGoogle()
                    }
                    
                    HStack{
                        Text("Don't have an account ?").padding(.trailing, 10)
                        NavigationLink(destination: SignUp()){
                            Text("Đăng Ký").foregroundColor(.blue)
                        }
                    }.padding(.vertical, 12)
                    
                    if isLogin{
                        NavigationLink(destination: TabViewNavigation(), isActive: $isLogin) {
                            EmptyView()
                        }
                    }
                    
                }.padding(.all)
                
            }
        }
    }
    
    func loginBtn(){
        userModel.login(username: username, password: password)
    }
    
    
    func login(username: String, password: String){
        guard let url = URL(string: "http://localhost:8080/api/v1/users/login") else {
            print("Invalid url")
            return
        }
        
        let body: [String: String] = [
            "username": username,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch let error {
            print("Failed to serialize body:", error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            if httpResponse.statusCode == 200 {
                print("Đăng nhập thành công")
                isLogin = true
            } else {
                print("Đăng nhập không thành công!")
            }
        }.resume()
        
        
        
    }
    
    
    func loginWithGoogle(){
        
    }
    
}

//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        Login()
//    }
//}
