//
//  ReuseableTextField.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct ReuseableTextField: View {
    let genders = ["MALE", "FEMALE"]
    var imageName: String
    var placeholder: String
    @Binding var txtInput: String
//    @Binding var chooseGender:String?
    @State private var isSecureTextEntry:Bool = true
    @State private var selectedGenderIndex = 0
    @State private var birthDate = Date()
//    var selectedGender:Bool
    var hasError: Bool
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.clear)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(hasError ? Color.red : Color.black, lineWidth: 1) // Đường viền cong với góc cong
                    .frame(height: 50)
            )
            .overlay(HStack{
                Image(systemName: imageName)
//                if selectedGender {
//                    Picker(selection: $selectedGenderIndex, label: Text("Chọn")) {
//                        ForEach(0 ..< genders.count) { index in
//                            Text(self.genders[index]).tag(index)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .onChange(of: selectedGenderIndex) { index in
//                            chooseGender = genders[index]
//                        }
//                } else {
                    if imageName == "lock.fill" {
                        if isSecureTextEntry {
                            SecureField(placeholder, text: $txtInput)
                                .autocapitalization(.none)
                        } else {
                            TextField(placeholder, text: $txtInput)
                                .autocapitalization(.none)
                        }
                    } else {
                        TextField(placeholder, text: $txtInput)
                            .autocapitalization(.none)
                    }
//                }

                Spacer()
                
                if imageName == "lock.fill"{
                    Image(systemName: isSecureTextEntry ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            isSecureTextEntry.toggle()
                        }
                }
            }.padding(.all))
            .padding(.bottom, 12)
            .padding(.top, 12)
            .shadow(color: Color.black.opacity(0.5), radius: 5,x: 0,y:2)
    }
}

//struct ReuseableTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        ReuseableTextField(imageName: "person.fill",txtInput: "s").previewLayout(.sizeThatFits)
//    }
//}
