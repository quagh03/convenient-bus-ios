//
//  DropdownBus.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/04/2024.
//

import SwiftUI
import Combine

struct DropdownBus: View {
    @EnvironmentObject var dataHolder: DataHolder
    @State var show = false
    @State var nameVehicle: String = "Biển số xe"
    @ObservedObject var vehicleAPI = VehicleAPI()
    
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
                                ForEach(vehicleAPI.allVehicle, id: \.id) { item in
                                    Button {
                                        withAnimation{
                                            dataHolder.nameVehicleDd = item.plateNumber
                                            dataHolder.vehicleIDDd = item.id
                                            show.toggle()
                                            check = false
                                            dataHolder.checkdd2 = false
                                        }
                                        print(item.id)
                                    } label: {
                                        Text(item.plateNumber)
                                            .foregroundColor((dataHolder.vehicleIDDd == item.id && dataHolder.isStartSession) ? .red:.black).bold()
                                        
                                    }
                                }
                                .padding(.horizontal)
                                .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity,alignment:.leading)
                            .padding(.vertical,15)
                    }.zIndex(20)
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
                            Text(dataHolder.nameVehicleDd ?? "Biển số xe")
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
                            dataHolder.checkdd2 = true
                        }
                    }
                    //end
                
                
            }
        }
        .disabled(dataHolder.isStartSession)
        .zIndex(20)
        .onAppear{
            vehicleAPI.getAllVehicle(tokenLogin: dataHolder.tokenLogin)
            dataHolder.nameVehicleDd = nameVehicle
        }
        .onReceive(Just(check)) { _ in
            // Gọi lại fetchData() mỗi khi check thay đổi từ false sang true
            if (check && !previousCheck) || (dataHolder.checkdd2 && !dataHolder.preCheckdd2) {
                vehicleAPI.getAllVehicle(tokenLogin: dataHolder.tokenLogin)
            }
            // Lưu trạng thái hiện tại của check cho lần sau
            previousCheck = check
        }
        .padding()   
    }
}

//struct DropdownBus_Previews: PreviewProvider {
//    static var previews: some View {
//        DropdownBus()
//    }
//}
