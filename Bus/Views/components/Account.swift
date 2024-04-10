//
//  Account.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct Account: View {
    let title: [String] = ["Họ", "Tên", "Ngày sinh", "Số điện thoại", "Email", "Giới tính", "Ngày tham gia"]
    var body: some View {
        VStack{
            ZStack{
                ReusableImage(color: "primary", height: 166, width: .infinity)
                Image(systemName: "person.fill")
            }
            
            ForEach(title.indices, id: \.self){index in
                ProfileRow(title: title[index], infor: "")
            }
            
            RoundedRectangle(cornerRadius: 8)
                .fill(.clear)
                .frame(height: 56)
                .overlay{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("lightGray"), lineWidth: 1)
                }
                .overlay{
                    Button {
                        
                    } label: {
                        HStack{
                            Text("Lịch sử chuyến đi")
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                        }.padding(.horizontal).foregroundColor(.black)
                    }
                }
                .padding(.top)
            
            Button {
                
            } label: {
                HStack{
                    Text("Đăng xuất").foregroundColor(.red)
                        .font(.system(size: 20))
                    Spacer()
                }.padding(.horizontal)
            }.padding(.top)

            
            
            Spacer()
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
