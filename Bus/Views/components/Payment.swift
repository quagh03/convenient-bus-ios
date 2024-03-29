//
//  Payment.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct Payment: View {
    var body: some View {
        VStack{
            ZStack(){
                ReusableImage(color: "primary", height: 60)
                Text("Thanh toán").foregroundColor(.white)
                    .bold()
                    .font(.system(size: 25))
            }
            Spacer()
            
            HStack{
                VStack{
                    ZStack{
                        
                    }
                }
            }
        }
    }
}

struct Payment_Previews: PreviewProvider {
    static var previews: some View {
        Payment()
    }
}
