//
//  PaymentHistory.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 04/04/2024.
//

import SwiftUI
import SlidingTabView

struct PaymentHistory: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack{
            ZStack(){
                ReusableImage(color: "primary", height: 60,width: .infinity)
                Text("Lịch sử giao dịch").foregroundColor(.white)
                    .bold()
                    .font(.system(size: 25))
            }
            
            // sliding
            SlidingTabView(selection: $selectedTab, tabs: ["Tất cả", "Nạp Tiền","Thanh toán"], animation: .easeInOut, activeAccentColor: .blue, selectionBarColor: .blue)
            Spacer()
            
            
        }
    }
}

struct PaymentHistory_Previews: PreviewProvider {
    static var previews: some View {
        PaymentHistory()
    }
}
