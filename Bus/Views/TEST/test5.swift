//
//  test5.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/04/2024.
//

import SwiftUI

struct test5: View {
    @State var index =  0
    var body: some View {
        VStack{
            Spacer()
            
            CustomTabNavDriver(index: $index, isPress: .constant(true))
        }
        .background(.gray).ignoresSafeArea()
    }
}

struct test5_Previews: PreviewProvider {
    static var previews: some View {
        test5()
    }
}
