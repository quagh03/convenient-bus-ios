//
//  BarBackCustom.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 02/04/2024.
//

import SwiftUI

struct BarBackCustom: View {
    @Environment(\.presentationMode) var presentationMode
    var nameRoute: String
    var body: some View {
        ZStack(alignment:.leading){
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                Spacer()
            }
            
        }.frame(maxWidth: .infinity)
            .overlay{
                Text(nameRoute).bold().font(.system(size: 18)).foregroundColor(.blue)
            }
    }
}

struct BarBackCustom_Previews: PreviewProvider {
    static var previews: some View {
        BarBackCustom(nameRoute: "E01")
    }
}
