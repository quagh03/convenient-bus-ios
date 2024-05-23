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
    @EnvironmentObject var toast: Toast
    var body: some View{
        ZStack {
//            Button {
                
//            } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 15, height: 25)
                    .foregroundColor(.black)
//            }

        }
        .padding()
        
    }
    
    func x(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            withAnimation {
                isPress2 = false
            }
            
        }
    }
    
    
}

struct test3_Previews: PreviewProvider {
    static var previews: some View {
        RootView{
            test3()
        }
    }
}

