//
//  TestToast.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 02/05/2024.
//

import SwiftUI

struct TestToast: View {
    @State private var isPress: Bool = false
    var body: some View {
        
        NavigationView {
            ZStack{
                ZStack{
                    ScrollView{
                        VStack{
                            VStack{
                                Button {
                                    isPress = true
                                } label: {
                                    Text("Press")
                                }
                                
                                
                            }
                        }
                        
                        
                    }
                }
                
                ZStack{
                    if isPress {
                        ToastM(tint: .clear, title: "hafhshfijb").onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                                withAnimation {
                                    isPress = false
                                }
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
}

struct TestToast_Previews: PreviewProvider {
    static var previews: some View {
        TestToast()
    }
}
