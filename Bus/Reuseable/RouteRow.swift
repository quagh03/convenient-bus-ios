//
//  RouteRow.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 26/03/2024.
//

import SwiftUI

struct RouteRow: View {
    let busRoute: BusRoute
//    let busRouteCombine: CombinedBusRoute
//    let onTap: ()->Void
//    @Binding var name: String?
    @EnvironmentObject var dataHolder: DataHolder
    
//    let busRouteDetail : BusRouteDetail
    
    @State private var isPressRow: Bool = false
    var body: some View {
            ZStack(alignment:.bottom){
                HStack{
                    // infor
//                    Button {
//                    } label: {
                        VStack(alignment: .leading){
                            Group{
                                Text(busRoute.routeName)
                                    .bold()
                                    .lineSpacing(10)
                                    .font(.system(size: 20))
                                    .padding(.bottom, 1)
                                Text("\(busRoute.startPoint.stopPoint) - \(busRoute.endPoint.stopPoint)")
                                    .lineSpacing(10)
                                    .font(.system(size: 16))
                                    .padding(.bottom,1)
                                
                            }
                            HStack(){
                                Group(){
                                    
                                    HStack(){
                                        //time
                                        Group{
                                            Image("clock")
                                            Text("05:00-21:00").foregroundColor(.gray)
                                                .font(.system(size: 15))
                                        }
                                        Rectangle().frame(width: 1,height: 22)
                                        Group{
                                            Image("money")
                                            Text("8.000 VND").foregroundColor(.gray)
                                                .font(.system(size: 15))
                                        }
                                        
                                    }
                                }
                                
                                
                            }
                        }.padding(.trailing,10)
                        // end Vstack
//                    }
                    
                    Spacer()
                    // favorite
                    Button(action: {
                        
                    }){
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 28, height: 28)
                            .overlay {
                                Image(systemName: "heart").resizable().frame(width: 28, height: 28).foregroundColor(.black)
                            }
                    }.padding(.trailing, 10)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 15, height: 25)
                            .foregroundColor(.black)
                    }
                    
                    // end hStack 1
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .edgesIgnoringSafeArea(.horizontal)
                
                //end ZSTack
            }
    }
}

//struct RouteRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RouteRow()
//    }
//}
