//
//  Balance.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/03/2024.
//

import SwiftUI

struct Balance: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(.clear)
            .frame(height: 140)
            .overlay{
                HStack{
                    VStack{
                      Text("Số dư của bạn")
                        
                    }
                }
            }
    }
}

struct Balance_Previews: PreviewProvider {
    static var previews: some View {
        Balance()
    }
}
