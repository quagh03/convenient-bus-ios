//
//  test4.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 16/04/2024.
//

import SwiftUI

struct test4: View {
    @Environment(\.dismiss) var dismiss
    @State private var isStart = false
        @State private var showingConfirmation = false
    var body: some View{
        Button {
            showingConfirmation = true
//            if isStart {
////                                    dutyAPI.startSession(driverID:dataHolder.idUser!, routeID: dataHolder.routeIDDd!, vehicleID: dataHolder.vehicleIDDd!)=
//            } else {
//
//            }
        } label: {
            Rectangle().fill(Color("primary"))
                .frame(maxWidth: .infinity ,maxHeight: 36)
                .shadow(radius: 5, x: 1, y:2)
                .overlay{
                    Text(!isStart ? "START":"CLOSE").font(.system(size: 14))
                }
        }.foregroundColor(.white).padding(.horizontal).zIndex(1)
            .alert(isPresented: $showingConfirmation) {
                Alert(
                    title: Text("Xác nhận"),
                    message: !isStart ? Text("Bạn chắc chắn muốn bắt đầu phiên làm việc?") : Text("Bạn chắc chắn muốn kết thúc phiên làm việc?"),
                    primaryButton: .default(Text("Start")) {
                        // Xử lý khi người dùng chọn "Start"s
                        !isStart ? self.startSession() : self.closeSession()
                    },
                    secondaryButton: .cancel()
                )
            }
    }
    
    func startSession() {
            self.isStart = true
            // Thực hiện các hành động khác nếu cần
            print("start session")
        }
    
    func closeSession() {
        self.isStart = false
        print("close session")
    }
}

struct test4_Previews: PreviewProvider {
    static var previews: some View {
        test4()
    }
}
