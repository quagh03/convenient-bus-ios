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
    @State private var isSignUpActive = false
    @EnvironmentObject var navigationManager: NavigationManager
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("background").resizable().ignoresSafeArea()
                VStack{
                    Image("VinBus_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                        .padding(.bottom, 50)
                    ReuseableTextField(imageName: "mail.fill", placeholder: "Email" ,txtInput: $username,selectedGender: false)
                    ReuseableTextField(imageName: "lock.fill", placeholder: "Password" ,txtInput: $password,selectedGender: false)
                    ReuseableTextField(imageName: "lock.fill", placeholder: "Confirm Password" ,txtInput: $confirmPassword,selectedGender: false)
                    
                    HStack{
                        ReuseableButton(red: 8/255,green: 141/255,blue: 224/255,text: "SignUp", width: .infinity,imgName: "", textColor: .white) {
                                signUp()
                            }
                                
                        NavigationLink(destination: FillInInformation(), isActive: $isSignUpActive) {
                            EmptyView()
                        }
                        .hidden()
                        
                    }.padding(.top, 10)
                    
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
                    
                    ReuseableButton(red: 255/255, green: 255/255, blue: 255/255, text: "SignUp with Google", width: .infinity , imgName: "loginwithgg", textColor: .black) {
                        signUpWithGoogle()
                    }
                    
                }.padding(.all)
                
            }
        }
    }
    
    func signUp(){
        isSignUpActive = true
    }
    
    func signUpWithGoogle(){
        
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
