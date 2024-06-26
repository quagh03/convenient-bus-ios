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
    @ObservedObject var userAPI = UserAPI()
    @ObservedObject var busRouteAPI = BusRoutesApi()
    @ObservedObject var vehicleAPI = VehicleAPI()
    @StateObject var dutyAPI = DutyAPI()
    @ObservedObject var tripAPI = TripAPI()
    @State private var bottomPadding: CGFloat = 0
    @State var isStart:Bool = false
    
    @State private var isProcessing = false
    
    @Binding var check: Bool
    
    var body: some View {
        ZStack{
            VStack {
                VStack{
                    ZStack(){
                        ReusableImage(color: "primary", height: 93,width: .infinity)
                        HStack{
                            Rectangle()
                                .fill(.white)
                                .frame(width: 40, height: 40)
                                .overlay{
                                    Image("logo").resizable().frame(width: 40, height: 40)
                                        .foregroundColor(.white)
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
                                    Rectangle().fill(dataHolder.nameRouteDd == "Tuyến xe" || dataHolder.nameVehicleDd == "Biển số xe" ? .gray : Color("primary"))
                                        .frame(maxWidth: .infinity ,maxHeight: 36)
                                        .shadow(radius: 5, x: 1, y:2)
                                        .overlay{
                                            if isProcessing{
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle())
                                                    .padding()
                                            } else {
                                                Text(!dutyAPI.isStart ? "START":"CLOSE").font(.system(size: 14))
                                            }
                                        }
                                }
                                .disabled(dataHolder.nameRouteDd == "Tuyến xe" || dataHolder.nameVehicleDd == "Biển số xe")
                                .foregroundColor(.white).padding(.horizontal).zIndex(1)
                                .alert(isPresented: $showingConfirmation) {
                                    Alert(
                                        title: Text("Xác nhận"),
                                        message: !dutyAPI.isStart ? Text("Bạn chắc chắn muốn bắt đầu phiên làm việc?") : Text("Bạn chắc chắn muốn kết thúc phiên làm việc?"),
                                        primaryButton: .default(!dutyAPI.isStart ? Text("Start") : Text("Close")) {
                                            isProcessing = true
//                                            !dutyAPI.isStart ? dutyAPI.startSession(driverID: dataHolder.idUser!, routeID: dataHolder.routeIDDd!, vehicleID: dataHolder.vehicleIDDd!, tokenLogin: dataHolder.tokenLogin) : dutyAPI.finishSession(id: dutyAPI.sessionId!, tokenLogin: dataHolder.tokenLogin)
//                                            
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//                                                dataHolder.isStartSession = dutyAPI.isStart
//                                                dataHolder.sessionId = dutyAPI.sessionId!
//                                                isProcessing = false
//                                            }
                                            Task {
                                                if !dutyAPI.isStart {
                                                    do{
                                                        try await dutyAPI.startSession(driverID: dataHolder.idUser!, routeID: dataHolder.routeIDDd!, vehicleID: dataHolder.vehicleIDDd!, tokenLogin: dataHolder.tokenLogin)
                                                        DispatchQueue.main.async{
                                                            dataHolder.isStartSession = dutyAPI.isStart
                                                            dataHolder.sessionId = dutyAPI.sessionId!
//                                                            dataHolder.routeSelected=true
                                                            isProcessing = false
                                                        }
                                                    } catch {
                                                        print("Failed to start session: \(error)")
                                                    }
                                                } else {
                                                    do{
                                                        try await dutyAPI.finishSession(id: dutyAPI.sessionId!, tokenLogin: dataHolder.tokenLogin)
                                                        isProcessing = false
                                                        dataHolder.vehicleSelected = false
//                                                        dataHolder.routeSelected = false
                                                    }catch{
                                                        print("Failed to finish session: \(error)")
                                                    }
                                                }
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
                .padding(.top, bottomPadding)
                .edgesIgnoringSafeArea(.top)
                
                Spacer()
            }
            
//            ZStack{
                if check{
                    if dataHolder.isAddTripSuccess {
                        ToastM1(symbol:"checkmark" ,tint: .clear, title: "Thanh toán thành công").zIndex(50)
                    } else if !dataHolder.isAddTripSuccess {
                        ToastM1(symbol:"xmark" ,tint: .clear, title: "Thanh toán thất bại").zIndex(50)
                    }
                }
//            }.zIndex(50)
        }
        .onAppear{
            if let window = UIApplication.shared.windows.first {
                bottomPadding = window.safeAreaInsets.bottom
            }
//            userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
        }
    }
    
}


//struct Driver_Previews: PreviewProvider {
//    static var previews: some View {
//        Driver()
//    }
//}
