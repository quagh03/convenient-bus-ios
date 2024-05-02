//
//  Login.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct Login: View {
    @State private var tokenLogin: String?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignUpButtonTapped = false
    @State private var gender: String = ""
    
    @ObservedObject private var userModel = LoginApi()
    
    @EnvironmentObject var dataHolder:  DataHolder
//    @Published var userLog: user?
    @State private var isLogin: Bool = false
    
    @State var showSignUpView: Bool = false
//    let busRouteDetail: BusRouteDetail
    
    @ObservedObject var faceIDAuth = FaceIDAuthentication()
    
    var body: some View {
        NavigationView{
            ZStack{
                ZStack{
                    ScrollView{
                        //                Image("").resizable().ignoresSafeArea()
                        //                Image("logo").resizable()
                        HeightSpacer(heightSpacer: 20)
                        VStack{
                            VStack{
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 125, height: 125)
                                    .padding(.bottom, 50)
                                Text("BUS CONVENIENT").font(.system(size: 30)).offset(y:-30)
                                    .foregroundColor(Color("primary"))
                            }
                            ReuseableTextField(imageName: "person.fill", placeholder: "Tài khoản" ,txtInput: $username, hasError: isSignUpButtonTapped && username.isEmpty)
                            ReuseableTextField(imageName: "lock.fill", placeholder: "Mật khẩu" ,txtInput: $password, hasError: isSignUpButtonTapped && password.isEmpty)
                            
                            HStack{
                                ReuseableButton(red: 8/255,green: 141/255,blue: 224/255,text: "Đăng nhập", width: 280,imgName: "", textColor: .white) {
                                    //                            login(username: username, password: password)
                                    login(username: username, password: password)
                                }
                                Spacer()
                                
                                Button {
                                    faceIDAuth.authenticate()
                                } label: {
                                    Image(systemName: "faceid")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.black)
                                        .offset(x: -2)
                                }.alert(isPresented: $faceIDAuth.showingAlert) {
                                    Alert(title: Text("Authentication Failed"), message: Text(faceIDAuth.biometricError?.localizedDescription ?? "Unable to authenticate using Face ID."), dismissButton: .default(Text("OK")))
                                }
                                
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
                            
                            ReuseableButton(red: 255/255, green: 255/255, blue: 255/255, text: "Đăng nhập bằng Google", width: .infinity , imgName: "loginwithgg", textColor: .black) {
                                isSignUpButtonTapped = true
                                loginWithGoogle()
                            }.overlay{
                                
                            }
                            
                            HStack{
                                Text("Chưa có tài khoản?").padding(.trailing, 10)
                                //                        if !showSignUpView{
                                NavigationLink(destination: SignUp()){
                                    Text("Đăng Ký").foregroundColor(.blue)
                                }
                                //                        }
                            }.padding(.vertical, 12)
                            
                            if isLogin{
                                NavigationLink(destination: TabViewNavigation(), isActive: $isLogin) {
                                    EmptyView()
                                }
                            }
                            
                        }.padding(.all)
                        
                    }
                }
                
                // toast
                ZStack{
                    if isLogin == false{
                        ToastM(tint: .clear, title: "Tài khoản hoặc mật khẩu không chính xác")
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
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
            
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Đăng nhập thành công")
                
                //
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        if let token = json["data"] as? String {
                            DispatchQueue.main.async {
                                dataHolder.tokenLogin = token
                                print(token)
                            }
                            print(token)
                        } else{
                            print("không có token")
                        }
                    }
                } catch {
                    print("Failed to decode JSON")
                }
                
                isLogin = true
                
            } else {
                print("Đăng nhập không thành công!")
                isLogin = false
            }
        }.resume()
    }
    
    
    func loginWithGoogle(){
        
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
