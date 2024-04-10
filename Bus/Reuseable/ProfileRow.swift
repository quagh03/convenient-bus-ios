//
//  ProfileRow.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 10/04/2024.
//

import SwiftUI

struct ProfileRow: View {
    var title: String
    var infor: String
    var body: some View {
        Rectangle()
            .fill(.clear)
            .frame(height: 52)
            .overlay{
                Rectangle()
                    .stroke(Color("lightGray"), lineWidth: 1)
                    .frame(height: 1)
                    .offset(y: 52/2)
                    
            }
            .overlay{
                HStack{
                    Text(title)
                    Spacer()
                    Text(infor)
                }.padding(.horizontal)
            }
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow(title: "ho", infor: "Nguyen")
    }
}
