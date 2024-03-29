//
//  CustomRowStopStatic.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/03/2024.
//

import SwiftUI

struct CustomRowStopStatic: View {
    var body: some View {
        HStack(){
            // icon
            VStack(){
                ZStack{
                    Rectangle()
                        .foregroundColor(Color("primary"))
                        .frame(width: 1, height: 20)
                        .offset(y:-14)
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("lightBlue"))
                    Rectangle()
                        .frame(width: 1, height: 20)
                        .foregroundColor(Color("primary"))
                        .offset(y:14)
                }
            }
            // info
            Text("Tuyến đường 01")
            Spacer()
        }
    }
}

struct CustomRowStopStatic_Previews: PreviewProvider {
    static var previews: some View {
        CustomRowStopStatic()
    }
}
