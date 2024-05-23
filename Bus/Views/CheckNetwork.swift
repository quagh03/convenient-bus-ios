//
//  CheckNetwork.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 23/04/2024.
//

import SwiftUI

struct CheckNetwork: View {
    var refresh: () -> Void
    var body: some View {
        ZStack{
            VStack{
                Image("wifi").resizable().scaledToFit()
                    .frame(maxWidth: 128, maxHeight: 128)
                
                Text("Lỗi kết nối")
                    .font(.system(size: 32))
                    .padding(.bottom)
                
                VStack(spacing:5){
                    Text("Có vẻ thiết bị của bạn không có kết nối mạng.")
                    Text("Vui lòng kiểm tra lại đường truyền")
                }.font(.system(size: 16))
                
                Button {
                    refresh()
                } label: {
                    RoundedRectangle(cornerRadius: 12).fill(Color("primary"))
                        .frame(maxWidth: 100, maxHeight: 46)
                        .overlay{
                            Text("Thử lại").foregroundColor(.white)
                        }
                }.padding(.top,50)
            }
        }
    }
}

struct CheckNetwork_Previews: PreviewProvider {
    static var previews: some View {
        CheckNetwork(refresh: {})
    }
}
