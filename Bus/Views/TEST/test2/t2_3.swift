//
//  t2_3.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 22/5/24.
//

import SwiftUI

struct t2_3: View {
    @Binding var pressed2: Bool
    @Environment(\.presentationMode) var mode
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                pressed2 = true
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }.onChange(of: pressed2, perform: { value in
            if value{
                mode.wrappedValue.dismiss()
            }
        })
    }
}

#Preview {
    t2_3(pressed2: .constant(true))
}
