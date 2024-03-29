//
//  CustomRowStopStatic.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/03/2024.
//

import SwiftUI

struct CustomRowStopStatic: View {
    @State var isFirst: Bool
    var body: some View {
        HStack(){
            // icon
            VStack(){
                ZStack{
                    if !isFirst {
                        Rectangle()
                            .foregroundColor(Color("primary"))
                            .frame(width: 1, height: 24)
                            .offset(y:-16)
                    }
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("lightBlue"))
                    Rectangle()
                        .frame(width: 1, height: 24)
                        .foregroundColor(Color("primary"))
                        .offset(y:19)
                }
            }
            // info
            Text("Tuyến đường 01").padding(.vertical)
            Spacer()
        }
    }
}

struct CustomRowStopStatic_Previews: PreviewProvider {
    static var previews: some View {
        CustomRowStopStatic(isFirst: true)
    }
}
