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
        VStack{
            ZStack() {
                // menu
                ZStack{
                    RoundedRectangle(cornerRadius: 0)
                    //                        .fill(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(.gray,lineWidth: 1)
                        }
                    ScrollView {
                        VStack(spacing: 17){
                            ForEach(1..<3, id: \.self) { item in
                                Button {
                                    
                                } label: {
                                    Text("sdsd")
                                        .foregroundColor(.black).bold().padding(.vertical,4)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding(.vertical,15)
                    }
                }
                .foregroundColor(.white.opacity(1))
                .frame(height: show ? 100 : 60)
                .offset(y: show ? 85 : 0)
                
                // text hien thi
                ZStack{
                    RoundedRectangle(cornerRadius: 0).frame(height: 60)
                        .foregroundColor(.white)
                        .overlay{
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(.gray,lineWidth: 1)
                        }
                    HStack{
                        Text("Tuyến xe")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .rotationEffect(.degrees(show ? 90 : 0))
                    }.padding(.horizontal)
                }
                //                .offset(y: -145)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                        check = true
                    }
                }
                //end
            }
        }
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
