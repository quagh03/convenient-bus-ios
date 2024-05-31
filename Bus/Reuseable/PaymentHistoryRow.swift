//
//  PaymentHistoryRow.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 05/04/2024.
//

import SwiftUI

struct PaymentHistoryRow: View {
    @State var imgName: String
    @State var title: String
    @State var time: String
    @State var amount: String
    @State var status: String
    @State var color: Color
    
    var body: some View {
        ZStack{
            Rectangle().fill(.clear)
                .frame(height: 81)
                .overlay(
                    Rectangle()
                        .fill(.gray)
                        .frame(height: 1) // Độ dày của đường viền
                        .padding(.top, 81), // Đẩy lên đến cạnh dưới
                    alignment: .bottom
                )

                .overlay{
                    HStack{
                        // image
                        Image(imgName)
//                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 32, height: 32)
//                            .foregroundColor(.green)
                            .scaledToFit()
                        
                        WidthSpacer(widthSpacer: 1)
                        
                        // info
                        VStack(alignment: .leading, spacing: 6){
                            Text(title)
                                .font(.system(size: 18))
                            Text(time)
                                .font(.system(size: 14))
                        }
                        
                        WidthSpacer(widthSpacer: 1)
                        Spacer()
                        
                        // pay
                        VStack(alignment: .center, spacing: 6){
                            Text(amount).font(.system(size: 18))
                            Text(status)
                                .font(.system(size: 14))
                                .foregroundColor(color)
                        }
                    }.padding(.horizontal)
                }
        }
    }
}

struct PaymentHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        PaymentHistoryRow(imgName: "minusCard", title: "Nap tien", time: "9:05 - 28/3/2024", amount: "-60000 VND", status: "Thành công", color: .green)
    }
}
