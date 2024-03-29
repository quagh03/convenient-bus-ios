//
//  DetailBusRoute.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/03/2024.
//

import SwiftUI

struct DetailBusRoute: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack{
            HStack{
                // name route
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color("primary"))
                    .frame(width: 50, height: 50)
                    .overlay{
                        Text("E01")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .bold()
                    }
                
                // direction
                VStack(alignment:.leading){
                    Text("Chiều đi - xuất phát từ:").padding(.bottom,1)
                    Text("Bến xe Mỹ Đình").padding(.top,-4)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("primary"))
                        .frame(width: 102, height: 50)
                        .overlay{
                            Button(action:{
                                
                            }){
                                HStack{
                                    Image("switch1")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 20,height: 20)
                                        .foregroundColor(.white)
                                    Text("Chiều đi")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                }
                
                ///end HStack
            }
            TopTabNavigation(selectedTab: $selectedTab).padding(.vertical)
            VStack(alignment:.leading){
                TabView(selection: $selectedTab) {
                    ScrollView{
                        HStack(alignment: .top){
                            StopRoute()
                                .padding(.vertical)
                                .tag(0)
                        }
                    }
                    
                    Text("123").tag(1)
                }
            }
            
            Spacer()
        }.padding(.all)
        // end VStack
        
        
        
    }
}


struct DetailBusRoute_Previews: PreviewProvider {
    static var previews: some View {
        DetailBusRoute()
    }
}

