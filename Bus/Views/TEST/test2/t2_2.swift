//
//  t2_2.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 22/5/24.
//

import SwiftUI

struct t2_2: View {
    @State var pressed: Bool = false
    @Environment(\.presentationMode) var mode
    @State var pressed2: Bool = false
    var body: some View {
        
        NavigationView{
            VStack{
                Text("Page 2")
                
                Button(action: {
                    pressed = true
//                    mode.wrappedValue.dismiss()
                }, label: {
                    Text("To page 3")
                })
            }
        }
        .sheet(isPresented: $pressed, onDismiss: {
            if pressed2 {
                mode.wrappedValue.dismiss()
            }
        }) {
            t2_3(pressed2: $pressed2)
        }
    }
}

#Preview {
    t2_2()
}
