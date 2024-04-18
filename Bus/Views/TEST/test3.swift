//
//  test3.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 16/04/2024.
//

import SwiftUI
import Combine

struct test3: View {
    @State var isPress2 : Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View{
        NavigationView{
            VStack{
                Text("Screen 2")
                Button {
                    x()
                } label: {
                    Text("Press 2")
                }
                
                if isPress2 {
                    NavigationLink(destination: test4(), isActive: $isPress2) {
                        EmptyView()
                    }
                }
                
            }
        }.navigationTitle("2")
        
    }
    
    func x(){
        isPress2.toggle()
        dismiss()
    }
}

struct test3_Previews: PreviewProvider {
    static var previews: some View {
        test3()
    }
}
