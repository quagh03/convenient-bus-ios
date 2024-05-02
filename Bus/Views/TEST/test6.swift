//
//  test6.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/04/2024.
//

import SwiftUI

struct test6: View {
    var body: some View {
//        ScannerView()
        

        
        NavigationView {
            
            NavigationLink {
                Login()
            } label: {
                Button {
        //            dataHolder.logout()
                } label: {
                    HStack{
                        Text("Đăng xuất").foregroundColor(.red)
                            .font(.system(size: 20))
                        Spacer()
                    }.padding(.horizontal)
                }.padding(.vertical)
            }

        }
    }
}

struct test6_Previews: PreviewProvider {
    static var previews: some View {
        test6()
    }
}
