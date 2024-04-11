//
//  TEST.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 11/04/2024.
//

import SwiftUI

struct TEST: View {
    var body: some View {
        ZStack{
            ZStack{
                Image("default-avatar")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
            }
            .onTapGesture {
//                isShowingPicker = true
            }
            Text("Nguyen Hieu").offset(y:60)
        }.frame(maxWidth: .infinity)
    }
}

struct TEST_Previews: PreviewProvider {
    static var previews: some View {
        TEST()
    }
}
