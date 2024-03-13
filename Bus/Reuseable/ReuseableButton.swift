//
//  ReuseableButton.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct ReuseableButton: View {
    var red:Double
    var green:Double
    var blue:Double
    var text: String
    var width: Double
    var imgName: String
    var textColor: Color
    var action: () -> Void
    var body: some View {
        Button(action: action){
            RoundedRectangle(cornerRadius: 17)
                .fill(Color(red: red, green: green, blue: blue))
                .frame(width: .infinity,height: 50)
                .overlay(HStack{
                    if !imgName.isEmpty{
                        Image(imgName)
                            .resizable()
                            .scaledToFit()
                            .padding(.all)
                            .frame(height: 50)
                    }
                    Text(text).foregroundColor(textColor).padding(.all)
                })
        }
       
    }
}

struct ReuseableButton_Previews: PreviewProvider {
    static var previews: some View {
        ReuseableButton(red: 8/255,green: 141/255,blue: 224/255,text: "Login", width: 297,imgName: "loginwithgg", textColor: .white) {
            print("hello")
        }
    }
}
