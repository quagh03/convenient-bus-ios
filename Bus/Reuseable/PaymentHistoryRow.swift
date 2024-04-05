//
//  PaymentHistoryRow.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 05/04/2024.
//

import SwiftUI

struct PaymentHistoryRow: View {
    var body: some View {
        ZStack{
            Rectangle().fill(.clear)
                .frame(height: 81)
                .overlay{
                    Rectangle()
                        .stroke(.gray , lineWidth: 1)
                }
                .overlay{
                    HStack{
                        // image
                        Image("addCard")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.green)
                            .scaledToFit()
                        
                        WidthSpacer(widthSpacer: 1)
                        
                        // infot
                        VStack(alignment: .leading, spacing: 6){
                            Text("Thanh toán vé T4/2024")
                                .font(.system(size: 18))
                            Text("9:05 - 28/3/2024")
                                .font(.system(size: 14))
                        }
                        
                        WidthSpacer(widthSpacer: 1)
                        
                        // pay
                        VStack(alignment: .center, spacing: 6){
                            Text("-60000 VND").font(.system(size: 18))
                            Text("Thành công")
                                .font(.system(size: 14))
                                .foregroundColor(.green)
                        }
                    }
                }
        }
    }
}

struct PaymentHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        PaymentHistoryRow()
    }
}
