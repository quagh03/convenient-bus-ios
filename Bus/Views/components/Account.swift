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
    
    let title: [String] = ["Họ", "Tên", "Ngày sinh", "Số điện thoại", "Email", "Giới tính", "Ngày tham gia"]
    
    var body: some View {
        NavigationView{
            VStack{
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
                                isShowingPicker = true
                            }
                            HStack{
                                Text("\(userAPI.user?.lastName ?? "")")
                                Text("\(userAPI.user?.firstName ?? "")")
                            }.offset(y:60)
                        }.frame(maxWidth: .infinity)
                        
                    }
                    
                    ForEach(title.indices, id: \.self){index in
                        ProfileRow(title: title[index], infor: userDataForTitle(index))
                    }
                    
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
                                NavigationLink(destination: TripHistory()){
                                    HStack{
                                        //                                    NavigationLink(destination: TripHistory()){
                                        Text("Lịch sử chuyến đi").foregroundColor(.black)
                                        //                                    }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }.padding(.horizontal).foregroundColor(.black)
                                }
                            }
                        }
                        .padding(.top)
                    
                    NavigationLink(destination: Login(), isActive: $isLogOut) {
                        EmptyView()
                    }
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        HStack{
                            Text("Đăng xuất").foregroundColor(.red)
                                .font(.system(size: 20))
                            Spacer()
                        }.padding(.all)
                    }
                    
                    Spacer()
                }
            }
            
            
        }
        .onAppear{
            userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
        }
        .sheet(isPresented: $isShowingPicker) {
            PhotoPicker(avatarImage: $avatarImage)
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(title: Text("Xác nhận"), message: Text("Bạn có chắc chắn muốn đăng xuất?"), primaryButton: .destructive(Text("Đăng xuất"), action: {
                // Thực hiện việc đăng xuất và chuyển hướng về trang đăng nhập
                isLogOut = true
            }), secondaryButton: .cancel())
        }
    }
    
    //logout
    func logout(){
        
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


