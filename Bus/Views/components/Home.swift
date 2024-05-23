//
//  Home.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct Home: View {
    @State var isPressed:Bool = false
    @State private var selectionImage = 0
    @Binding var selection: Int
    @State private var isFavPress: Bool = false
    @State private var isBuyTicketPress: Bool = false
    @State private var isFeedbackPress: Bool = false
    
    
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var userAPI = UserAPI()
    @ObservedObject var ticketAPI = TicketAPI()
    
    @State private var bottomPadding: CGFloat = 0
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    VStack{
                        ZStack(alignment: .top){
                            ReusableImage(color: "primary", height: 190,width: .infinity)
                            HStack{
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 40, height: 40)
                                    .overlay{
                                        Image("logo").foregroundColor(.white)
                                    }
                                Text("BUS CONVENIENT").bold().foregroundColor(.white).font(.system(size: 32))
                            }.offset(y:33)
                        }
                        
                        VStack{
                            
                            // search
                            ReusableSearchbar(searchKey: "")
                                .padding(.all)
                                .offset(y: -80)
                            
                            // center
                            HStack{
                                // buy ticket
                                Button(action: {
                                    buyTicket()
                                }){
                                    ReusableFunc(imageName: "ticket", text: "Mua vé")
                                        .padding(.all)
                                        .foregroundColor(.black)
                                }
                                
                                // route
                                Button(action: {
                                    favorite()
                                }){
                                    ReusableFunc(imageName: "favorite", text: "Yêu thích")
                                        .padding(.all)
                                        .foregroundColor(.black)
                                }
                                
                                // feedback
                                Button(action: {
                                    feedback()
                                }){
                                    ReusableFunc(imageName: "feedback", text: "Đánh giá")
                                        .padding(.all)
                                        .foregroundColor(.black)
                                }
                                
                                
                            }.offset(y:-70)
                            
                            Image("Container").resizable().scaledToFit().offset(y:-40)
                            
                        }
                        
                        Spacer()
                    }
                }
            }.padding(.top, bottomPadding)
            .navigationBarHidden(true).edgesIgnoringSafeArea(.top)
        }
//        .navigationBarHidden(true)
//        .edgesIgnoringSafeArea(.top)
        .onAppear{
            if let window = UIApplication.shared.windows.first {
                bottomPadding = window.safeAreaInsets.bottom
            }
        }
        .onAppear{
            userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                dataHolder.idUser = userAPI.user?.id
                dataHolder.fNameUser = userAPI.user?.firstName
                dataHolder.lNameUser = userAPI.user?.lastName
                dataHolder.phoneUser = userAPI.user?.phoneNumber
                dataHolder.emailUser = userAPI.user?.email
                dataHolder.dobUser =  userAPI.user?.dob
                
                ticketAPI.getAllTicket(tokenLogin: dataHolder.tokenLogin, userID: dataHolder.idUser!)
            }
        }
        .fullScreenCover(isPresented: $isFavPress) {
            FavoriteScreen()
        }
        .fullScreenCover(isPresented: $isBuyTicketPress) {
            BuyTicket()
        }
    }
    
    func buyTicket(){
        isBuyTicketPress = true
//        ticketAPI.getAllTicket(tokenLogin: dataHolder.tokenLogin, userID: dataHolder.idUser!)
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
            if ticketAPI.isExist {
                dataHolder.isExistTicket = true
            } else {
                dataHolder.isExistTicket = false
            }
//        }
    }
    
    func favorite(){
        isFavPress = true
    }
    
    func feedback(){
        
    }
    
    
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home(selection: .constant(1))
//    }
//}
