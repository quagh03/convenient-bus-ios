//
//  Account.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI
import Combine

struct Account: View {
    @ObservedObject var userAPI = UserAPI()
    @EnvironmentObject var dataHolder: DataHolder
    
    @State private var isShowingPicker: Bool = false
    @State private var avatarImage = UIImage(named: "default-avatar")!
    
    @State private var isTripHistoryPressed: Bool = false
    
    @State private var showingLogoutAlert = false
    @Binding var isLogOut: Bool
    @ObservedObject var faceIDAuth = FaceIDAuthentication()
    
    @Binding var addTripSuccess: Bool
    
    let title: [String] = ["Họ", "Tên", "Ngày sinh", "Số điện thoại", "Email", "Giới tính", "Ngày tham gia"]
    
    var body: some View {
        NavigationView{
//            VStack{
                ScrollView{
                    ZStack{
                        ReusableImage(color: "primary", height: 166, width: .infinity)
                        ZStack{
                            ZStack{
                                Image(uiImage: avatarImage)
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 80, height: 80)
                            }
                            .onTapGesture {
//                                isShowingPicker = true
                            }
                            HStack{
                                Text("\(userAPI.user?.lastName ?? "")\(userAPI.user?.firstName ?? "")")
//                                Text("\(userAPI.user?.lastName ?? "")")
//                                Text("\(userAPI.user?.firstName ?? "")")
                            }.offset(y:60)
                        }.frame(maxWidth: .infinity)
                        
                    }
                    
                    ForEach(title.indices, id: \.self){index in
                        ProfileRow(title: title[index], infor: userDataForTitle(index))
                    }
                    
                    if userAPI.user?.role == "ROLE_GUEST"{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.clear)
                            .frame(height: 56)
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("lightGray"), lineWidth: 1)
                            }
                            .overlay{
                                Button {
                                    withAnimation {
                                        isTripHistoryPressed = true
                                    }
                                } label: {
                                    HStack{
                                        Text("Lịch sử chuyến đi").foregroundColor(.black)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }.padding(.horizontal).foregroundColor(.black)
                                }
                            }
                            .padding(.top)
                    }
                    
//                    NavigationLink(destination: Login().navigationBarHidden(true).navigationBarBackButtonHidden(true), isActive: $isLogOut) {
//                        EmptyView()
//                    }
                    
                    HeightSpacer(heightSpacer: 10)
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        HStack{
                            Text("Đăng xuất").foregroundColor(.red)
                                .font(.system(size: 20))
                            Spacer()
                        }.padding(.all)
                    }
                    
//                    NavigationLink(destination: Login().navigationBarHidden(true).navigationBarBackButtonHidden(true), isActive: $isLogOut) {
//                        EmptyView()
//                    }
                    
                    Spacer()
                }
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.top)
//            }
            
            
        }
        .fullScreenCover(isPresented: $isTripHistoryPressed, content: {
            TripHistory(addTripSuccess: addTripSuccess)
        })
        .onAppear{
            Task{
                do{
                    try await userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
                }catch{
                    print("Error fetching user data: \(error)")
                }
               
            }
        }
        .sheet(isPresented: $isShowingPicker) {
            PhotoPicker(avatarImage: $avatarImage)
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(title: Text("Xác nhận"), message: Text("Bạn có chắc chắn muốn đăng xuất?"), primaryButton: .destructive(Text("Đăng xuất"), action: {
                // Thực hiện việc đăng xuất và chuyển hướng về trang đăng nhập
                withAnimation {
                    isLogOut = true
                    restartApplication()
                    
                }
            }), secondaryButton: .cancel())
        }
    }
    
    //logout
    func restartApplication() {
//        DispatchQueue.main.asyncAfter(deadline: .now()) {
//            if let window = UIApplication.shared.windows.first {
//                // Khởi tạo lại giao diện người dùng với ContentView là màn hình khởi đầu
//                dataHolder.logout()
//                window.rootViewController = UIHostingController(rootView: Login().environmentObject(dataHolder))
//            }
//        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0 is UIWindowScene }) as? UIWindowScene {
                if let window = windowScene.windows.first {
                    // Khởi tạo lại giao diện người dùng với ContentView là màn hình khởi đầu
                    dataHolder.logout()
                    faceIDAuth.logOut()
                    window.rootViewController = UIHostingController(rootView: Login().environmentObject(dataHolder))
                }
            }
        }
    }
    
    //
    func userDataForTitle(_ index: Int) -> String {
        switch title[index]{
        case "Họ":
            return userAPI.user?.lastName ?? ""
        case "Tên":
            return userAPI.user?.firstName ?? ""
        case "Ngày sinh":
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            if let dateString = userAPI.user?.dob {
                if let dob = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    return dateFormatter.string(from: dob)
                }
            }
            return ""
        case "Số điện thoại":
            return userAPI.user?.phoneNumber ?? ""
        case "Email":
            return userAPI.user?.email ?? ""
        case "Giới tính":
            return userAPI.user?.gender ?? ""
        case "Ngày tham gia":
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            if let dateString = userAPI.user?.registeredAt {
                if let registeredAt = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    return dateFormatter.string(from: registeredAt)
                }
            }
            return ""
        default:
            return ""
        }
        
    }
    
}


