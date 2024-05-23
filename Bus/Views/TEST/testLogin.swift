//
//  Login.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//
import Combine
import SwiftUI

struct testLogin: View {
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

    @State var value: CGFloat = 0

    var body: some View {
        NavigationView{

//                ZStack{
            ScrollView{
                VStack{
                    VStack{
                        HeightSpacer(heightSpacer: 10)
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
                                //                            login(username: username, password: password)
                            }
                            Spacer()
                            //
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
                            //                        loginWithGoogle()
                        }
                        //
                        //                    Spacer()
                        //                    HStack{
                        //                        Text("Chưa có tài khoản?").padding(.trailing, 10)
                        //                        //                        if !showSignUpView{
                        //                        NavigationLink(destination: SignUp()){
                        //                            Text("Đăng Ký").foregroundColor(.blue)
                        //                        }
                        //                        //                        }
                        //                    }.padding(.vertical, 12)
                        
                        
                        
                        
                    }.padding(.all)
                    Spacer()
                    HStack{
                        Text("Chưa có tài khoản?").padding(.trailing, 10)
                        //                        if !showSignUpView{
                        NavigationLink(destination: SignUp()){
                            Text("Đăng Ký").foregroundColor(.blue)
                        }
                        //                        }
                    }.padding(.vertical, 12)
                }
            }
//                .offset(y: -self.value)
//                .animation(.spring())
//                .onAppear{
//                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { noti in
//                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//                        let height = value.height
//
//                        self.value = height
//                    }
//                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { noti in
//
//                        self.value = 0
//                    }
//                }
//                }

        }
        .navigationBarBackButtonHidden(true)

    }

}

struct testLogin_Previews: PreviewProvider {
    static var previews: some View {
        testLogin()
    }
}

