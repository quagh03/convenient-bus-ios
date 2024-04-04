//
//  Denomination.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 04/04/2024.
//

import SwiftUI

struct Denomination: View {
    var money: String
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("primary"))
            .frame(width: 98,height: 50)
            .overlay{
                Text(money)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
            }
    }
}

struct Denomination_Previews: PreviewProvider {
    static var previews: some View {
        Denomination(money: "20.000")
    }
}
