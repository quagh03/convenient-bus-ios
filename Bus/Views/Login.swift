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
    @State private var isShowing: Bool = false
    
    @State var showSignUpView: Bool = false
//    let busRouteDetail: BusRouteDetail
    @State private var isLoginLoad:Bool = false
    @ObservedObject var faceIDAuth = FaceIDAuthentication()
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    ZStack{
                        ScrollView{
                            //                Image("").resizable().ignoresSafeArea()
                            //                Image("logo").resizable()
                            HeightSpacer(heightSpacer: 25)
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
//                                    NavigationLink(destination: TabViewNavigation(), isActive: $isLogin || $faceIDAuth.isLoggedIn)
                                    NavigationLink(destination: TabViewNavigation(), isActive: Binding<Bool>(
                                        get: {
                                            self.isLogin || self.faceIDAuth.isLoggedIn
                                        },
                                        set: { _ in }
                                    ))
                                    {
                                        ReuseableButton(red: isLoginLoad ? 211/255 : 8/255,green: isLoginLoad ? 211/255 : 141/255,blue: isLoginLoad ? 211/255 : 224/255,text: isLoginLoad ? "Loading..." : "Đăng nhập", width: 280,imgName: "", textColor: .white) {
                                                isLoginLoad = true
                                                login(username: username, password: password)
                                            }.disabled(isLoginLoad)
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        if !dataHolder.tokenLogin.isEmpty{
                                            faceIDAuth.loginAction = { username, password in
                                                self.username = username
                                                self.password = password
                                                DispatchQueue.main.asyncAfter(deadline: .now()+1){
                                                    login(username: username, password: password)
                                                }
                                            }
                                            faceIDAuth.authenticate()
                                        }
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
                                }.overlay{}
                                
                                HStack{
                                    Text("Chưa có tài khoản?").padding(.trailing, 10)
                                    //                        if !showSignUpView{
                                    NavigationLink(destination: SignUp()){
                                        Text("Đăng Ký").foregroundColor(.blue)
                                    }
                                    //                        }
                                }.padding(.vertical, 12)
                                
                                //                            if isLogin{
                                //                                NavigationLink(destination: TabViewNavigation(), isActive: $isLogin) {
                                //                                    EmptyView()
                                //                                }
                                //                            }
                                
                            }.padding(.all)
                            
                        }
                    }
                    
                    // toast
                    ZStack{
                        if (isLogin == false && isShowing == true){
                            ToastM(tint: .clear, title: "Tài khoản hoặc mật khẩu không chính xác")
                        }
                    }
                    //            }
                    
                }
            }
            .frame(maxHeight: .infinity).navigationBarHidden(true).navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
//        .edgesIgnoringSafeArea(.top)
    }
    
    func loginBtn(){
        userModel.login(username: username, password: password)
    }
    
    
    func login(username: String, password: String){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/users/login") else {
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
                isLoginLoad = false
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
                dataHolder.savedUsername = username
                dataHolder.savedPassword = password
                
            } else {
                print("Đăng nhập không thành công!")
                isLogin = false
                isShowing = true
                isLoginLoad = false
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

