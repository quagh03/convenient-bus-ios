//
//  ReuseableTextField.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct GenderField: View {
    let genders = ["MALE", "FEMALE"]
    var imageName: String
    @Binding var chooseGender:String
    @State private var selectedGenderIndex = 0
    //    var selectedGender:Bool
    //    var hasError: Bool
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.clear)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1) // Đường viền cong với góc cong
                    .frame(height: 50)
            )
            .overlay(HStack{
                Image(systemName: imageName)
                
                Picker(selection: $selectedGenderIndex, label: Text("Chọn")) {
                    ForEach(0 ..< genders.count) { index in
                        Text(self.genders[index]).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedGenderIndex) { index in
                    chooseGender = genders[index]
                }
                
                
                Spacer()
                
            }.padding(.all))
            .padding(.bottom, 12)
            .padding(.top, 12)
            .shadow(color: Color.black.opacity(0.5), radius: 5,x: 0,y:2)
    }
}

struct GenderField_Preview: PreviewProvider {
    static var previews: some View {
        GenderField(imageName: "person.fill", chooseGender: .constant("MALE")).previewLayout(.sizeThatFits)
    }
}
