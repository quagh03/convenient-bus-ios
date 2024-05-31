//
//  Dropdown.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 24/04/2024.
//

import SwiftUI
import Combine

struct Dropdown: View {
    @EnvironmentObject var dataHolder: DataHolder
    @State var show = false
    @State var nameRoute: String = "Tuyến xe"
    @ObservedObject var busRouteAPI = BusRoutesApi()
    @State var didAppear = false
    @State var previousCheck = false

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
                            ForEach(busRouteAPI.busRoutes, id: \.id) { item in
                                Button {
                                    withAnimation{
                                        dataHolder.nameRouteDd = item.routeName
                                        dataHolder.routeIDDd = item.id
//                                        dataHolder.routeSelected = true
                                        show.toggle()
                                        check = false
                                        dataHolder.checkdd1 = false
                                    }
                                    print(item.id)
                                } label: {
                                    Text(item.routeName)
                                        .foregroundColor((dataHolder.routeIDDd == item.id && dataHolder.isStartSession) ? .red:.black).bold().padding(.vertical,4)
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
                .frame(height: show ? 100 : 36)
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
                        Text(dataHolder.nameRouteDd ?? "Tuyến xe")
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
                        dataHolder.checkdd1 = true
                    }
                }
                //end
            }
        }.disabled(dataHolder.isStartSession)
        .zIndex(20)
        .onAppear{
            busRouteAPI.fetchData()
            dataHolder.nameRouteDd = nameRoute
        }
        .onReceive(Just(check)) { _ in
            // Gọi lại fetchData() mỗi khi check thay đổi từ false sang true
            if (check && !previousCheck) || (dataHolder.checkdd1 && !dataHolder.preCheckdd1) {
                busRouteAPI.fetchData()
            }
            // Lưu trạng thái hiện tại của check cho lần sau
            previousCheck = check
        }
        .padding()
    }
}

//struct Dropdown_Previews: PreviewProvider {
//    static var previews: some View {
//        Dropdown()
//    }
//}
