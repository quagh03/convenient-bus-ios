//
//  test4.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 16/04/2024.
//

import SwiftUI

struct test4: View {
    @Environment(\.dismiss) var dismiss
    var body: some View{
        NavigationView{
            VStack{
                Button {
                    dismiss()
                } label: {
                    Text("Dismiss")
                }
            }
        }
    }
}

struct test4_Previews: PreviewProvider {
    static var previews: some View {
        test4()
    }
}
