//
//  CustomTabNavDriver.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/04/2024.
//

import SwiftUI

struct CustomTabNavDriver: View {
    @Binding var index: Int
    @Binding var isPress: Bool
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var userAPI = UserAPI()
    @State private var showAlert = false
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                // home
                Button {
                    self.index = 0
                } label: {
                    VStack{
                        Image(systemName: "car.fill")
                        HeightSpacer(heightSpacer: 1)
                        Text("Driver")
                    }
                    
                }.frame(maxWidth: .infinity)
                    .foregroundColor(.black.opacity(self.index == 0 ? 1 : 0.4)).edgesIgnoringSafeArea(.top)
                
                Spacer()
                
                
                //            if dutyAPI.isStart {
                Button {
                    if dataHolder.isStartSession{
                        isPress = true
                        showAlert = false
                    } else {
                        showAlert = true
                    }
                } label: {
                    ZStack{
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .frame(maxWidth: 35, maxHeight:35)
                            .foregroundColor(.blue)
                            .padding(10) // Add some padding to increase tap area
                            .zIndex(10)
                            .background(
                                Circle()
                                    .fill(Color.white) // Add a white background
                                //.shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2) // Add shadow
                            )
                    }
                }
                .foregroundColor(.blue)
                .offset(y: -25)
                .alert(isPresented: $showAlert){
                    Alert(
                        title: Text("Thông báo"),
                        message: Text("Bạn phải bắt đầu chuyến đi."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                
                Spacer()
                // account
                Button {
                    self.index = 1
                } label: {
                    VStack{
                        Image(systemName: "person.fill")
                        HeightSpacer(heightSpacer: 1)
                        Text("Account")
                    }
                }.frame(maxWidth: .infinity)
                    .foregroundColor(.black.opacity(self.index == 1 ? 1 : 0.4)).edgesIgnoringSafeArea(.top)
                
                Spacer()
            }.edgesIgnoringSafeArea(.bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.white)
        //        .padding(.horizontal,35)
        //        .padding(.top, 35)
//        .padding(.vertical)
        .clipShape(CShape())
        .onAppear{
            Task {
                do {
                    try await userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
                    
                    DispatchQueue.main.async {
                        dataHolder.idUser = userAPI.user?.id
                        dataHolder.fNameUser = userAPI.user?.firstName
                        dataHolder.lNameUser = userAPI.user?.lastName
                        dataHolder.phoneUser = userAPI.user?.phoneNumber
                        dataHolder.emailUser = userAPI.user?.email
                        dataHolder.dobUser = userAPI.user?.dob
                    }
                } catch {
                    print("Error fetching user data: \(error)")
                }
            }
        }
    }
}
struct CShape: Shape{
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            path.addArc(center: CGPoint(x: rect.width / 2, y: 0), radius: 35, startAngle: .init(degrees: 180), endAngle: .zero, clockwise: false)
        }
    }
}

//struct CustomTabNavDriver_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTabNavDriver(index: .constant(0), isPress: .constant(true))
//    }
//}
//
