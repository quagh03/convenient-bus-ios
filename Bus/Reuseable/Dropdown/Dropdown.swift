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
                                        show.toggle()
                                        check = false
                                    }
                                    print(item.id)
                                } label: {
                                    Text(item.routeName)
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
                    }
                }
                //end
            }
        }.zIndex(20)
        .onAppear{
            busRouteAPI.fetchData()
        }
        .onReceive(Just(check)) { _ in
            // Gọi lại fetchData() mỗi khi check thay đổi từ false sang true
            if check && !previousCheck {
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
