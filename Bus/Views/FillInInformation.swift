////
////  FillInInformation.swift
////  Bus
////
////  Created by Nguyễn Hữu Hiếu on 12/03/2024.
////
//
//import SwiftUI
//
//struct FillInInformation: View {
//    @State private var selectedGenderIndex = 0
//    @State private var chooseGender: String = ""
//    @State private var firstName: String = ""
//    @State private var lastName: String = ""
//    @State private var email: String = ""
//    @State private var phone: String = ""
//    @State private var birth: Date?
//    @EnvironmentObject var navigationManager: NavigationManager
//    var body: some View {
//        VStack{
//            Text("Đăng Ký")
//            ScrollView{
//                VStack {
//                    ReuseableTextField(imageName: "person.fill", placeholder: "Họ" ,txtInput: $lastName,selectedGender: false)
//                    ReuseableTextField(imageName: "person.fill", placeholder: "Tên" ,txtInput: $firstName,selectedGender: false)
//                    ReuseableTextField(imageName: "mail.fill", placeholder: "Email" ,txtInput: $email,selectedGender: false)
//                    ReuseableTextField(imageName: "phone.fill", placeholder: "Điện thoại" ,txtInput: $phone,selectedGender: false)
//                    ReuseableTextField(imageName: "figure.stand", placeholder: "", txtInput: $chooseGender, selectedGender: true)
//                    RoundedRectangle(cornerRadius: 12)
//                        .fill(.clear)
//                        .frame(height: 50)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.black, lineWidth: 1) // Đường viền cong với góc cong
//                                .frame(height: 50)
//                        )
//                        .overlay(
//                            HStack{
//                                Image(systemName: "calendar")
//                                DateTimePickerTextField(placeholder: "Ngày Sinh", date: $birth)
//                            }
//                                .padding(.all)
//                        )
//                        .padding(.bottom, 12)
//                        .padding(.top, 12)
//                }
//
//            }
//            .padding()
//        }
//    }
//}
//
//struct FillInInformation_Previews: PreviewProvider {
//    static var previews: some View {
//        FillInInformation()
//    }
//}
