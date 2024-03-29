//
//  ReusableFunc.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct ReusableFunc: View {
    var imageName: String
    var text: String
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(.clear)
                    .foregroundColor(Color.black)
                    .frame(width: 80,height:80)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("primary100"))
                            .shadow(color: .black, radius: 4,x: 0,y: 0)
                    ).clipShape(Circle())
                
                    Image(imageName).resizable().aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 42, height: 42)
            }
            Text(text)
        }
        
        
    }
}

struct ReusableFunc_Previews: PreviewProvider {
    static var previews: some View {
        ReusableFunc(imageName: "ticket", text: "Mua vé")
    }
}
