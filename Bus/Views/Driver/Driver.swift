//
//  Driver.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 20/04/2024.
//

import SwiftUI
//import UIKit

struct Driver: View {
    @EnvironmentObject var dataHolder: DataHolder
    @State private var isStartPressed:Bool = false
    @State private var showingConfirmation = false
    @ObservedObject var busRouteAPI = BusRoutesApi()
    @ObservedObject var vehicleAPI = VehicleAPI()
    @StateObject var dutyAPI = DutyAPI()
    @State var isStart:Bool = false
    var body: some View {
        VStack {
            VStack{
                ZStack(){
                    ReusableImage(color: "primary", height: 93,width: .infinity)
                    HStack{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 40, height: 40)
                            .overlay{
                                Image("logo").foregroundColor(.white)
                            }
                        Text("Bus Convenient").bold().foregroundColor(.white).font(.system(size: 32))
                    }
                }
                // content
                VStack {
                    ZStack(alignment:.bottom){
                        //title
                        VStack{
                            HStack{
                                Text("Thông tin").font(.system(size: 20)).bold()
                                Spacer()
                            }.padding(.horizontal)
                            
                            HeightSpacer(heightSpacer: 2)
                            
                            Group{
                                HStack{
                                    Text("Tuyến xe:")
                                    Spacer()
                                }.padding(.vertical,8)
                                    .padding(.horizontal)
                                
                                //                            HStack{
                                Dropdown().frame(maxWidth: .infinity, maxHeight: 60).zIndex(3)
                                //                                Spacer()
                                //                            }
                            }
                            HeightSpacer(heightSpacer: 80)
                        }.zIndex(3)
                        
                        VStack{
                            Group{
                                HStack{
                                    Text("Biển số xe:")
                                    Spacer()
                                }.padding(.vertical,8)
                                    .padding(.horizontal)

                                    DropdownBus().frame(maxWidth: .infinity,maxHeight: 60).zIndex(2)
                            }
                            HeightSpacer(heightSpacer: 80)
                        }.zIndex(2).offset(y:120)
                        // end VStack
                        
                        VStack{
                            Button {
                                showingConfirmation = true
                            } label: {
                                Rectangle().fill(Color("primary"))
                                    .frame(maxWidth: .infinity ,maxHeight: 36)
                                    .shadow(radius: 5, x: 1, y:2)
                                    .overlay{
                                        Text(!dutyAPI.isStart ? "START":"CLOSE").font(.system(size: 14))
                                    }
                            }.foregroundColor(.white).padding(.horizontal).zIndex(1)
                                .alert(isPresented: $showingConfirmation) {
                                    Alert(
                                        title: Text("Xác nhận"),
                                        message: !dutyAPI.isStart ? Text("Bạn chắc chắn muốn bắt đầu phiên làm việc?") : Text("Bạn chắc chắn muốn kết thúc phiên làm việc?"),
                                        primaryButton: .default(!dutyAPI.isStart ? Text("Start") : Text("Close")) {
                                            !dutyAPI.isStart ? dutyAPI.startSession(driverID: dataHolder.idUser!, routeID: dataHolder.routeIDDd!, vehicleID: dataHolder.vehicleIDDd!, tokenLogin: dataHolder.tokenLogin) : dutyAPI.finishSession(id: dutyAPI.sessionId!, tokenLogin: dataHolder.tokenLogin)
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                                dataHolder.isStartSession = dutyAPI.isStart
                                            }
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                        }.zIndex(1).offset(y: 100)
                    }
                }
                Spacer()
            }
        }
    }
    
}


//struct Driver_Previews: PreviewProvider {
//    static var previews: some View {
//        Driver()
//    }
//}
