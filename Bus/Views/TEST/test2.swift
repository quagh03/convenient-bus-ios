//
//  test2.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 16/04/2024.
//

import SwiftUI
import Combine

struct test2: View {
    @State var connected : Bool = false
    @State private var isLoading: Bool = false
    @ObservedObject var monitor = NetworkMonitor()
    
    @EnvironmentObject var dataHolder: DataHolder
    @State var show = false
    @State var nameRoute: String = "Tuyến xe"
    @State var didAppear = false
    @State var previousCheck = false
    
//    let busRoutes: [BusRoute]
    @State var check = false
    var body: some View {
        ZStack{
            Button(action: {show = true}, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            
            if show {
                AlertPaymentSuccess(isReturn: .constant(false))
                    
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
    
    func startCheck(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            if monitor.isConnected {
                isLoading = false
                connected = true
            } else{
                isLoading = false
                connected = false
            }
        }
    }
    
}




struct test2_Previews: PreviewProvider {
    static var previews: some View {
        test2()
    }
}
