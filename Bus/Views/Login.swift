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
    var body: some View {
        NavigationView{
            ZStack{
                Image("background").resizable().ignoresSafeArea()
                VStack{
                    Image("VinBus_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                        .padding(.bottom, 50)
                    ReuseableTextField(imageName: "person.fill", placeholder: "Username/Email" ,txtInput: $username,selectedGender: false)
                    ReuseableTextField(imageName: "lock.fill", placeholder: "Password" ,txtInput: $password,selectedGender: false)
                    
                    HStack{
                        ReuseableButton(red: 8/255,green: 141/255,blue: 224/255,text: "Login", width: 280,imgName: "", textColor: .white) {
                            login()
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
                        loginWithGoogle()
                    }
                    
                    HStack{
                        Text("Don't have an account ?").padding(.trailing, 10)
                        NavigationLink(destination: SignUp()){
                            Text("SignUp").foregroundColor(.blue)
                        }
                    }.padding(.vertical, 12)
                    
                }.padding(.all)
                
            }
        }
    }
    
    func login(){
        if username == "hieu1" && password == "123456" {
            print("Login successful")
            // Navigate to the next view or perform other actions upon successful login
        } else {
            print("Login failed")
            // Show an alert or update the UI to indicate login failure
        }
        navigationManager.navigateTo(page: "FillInInformation")
    }
    
    func loginWithGoogle(){
        
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
