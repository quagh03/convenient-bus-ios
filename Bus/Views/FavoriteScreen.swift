//
//  FavoriteScreen.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/04/2024.
//

import SwiftUI
import Combine

struct FavoriteScreen: View {
    @EnvironmentObject private var favorites: Favorites
    @EnvironmentObject var dataHolder: DataHolder
    @StateObject var viewModel = BusRoutesApi()
    @State private var isTap: Bool = false
    @State private var favoriteChanged: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    ReusableImage(color: "primary", height: 65, width: .infinity)
                    BarBackCustom(back: "",color: .white, nameRoute: "Yêu thích").padding(.horizontal)
                }
                
//                if viewModel.busRouteFavorite.isEmpty{
//                    VStack{
//                        Text("Chưa có dữ liệu").foregroundStyle(.gray).offset(y:50)
//                    }
//                }else{
                    ScrollView{
                        ForEach(viewModel.busRouteFavorite, id: \.id) { favorite in
                            RouteRow(busRoute: favorite, favoriteChanged: $favoriteChanged)
                                .onTapGesture {
                                    dataHolder.nameRouteDetail = favorite.routeName
                                    isTap = true
                                }
                        }.onAppear{
                            viewModel.favoriteIDs = favorites.saveItems
                            viewModel.fetchData()
                        }
//                        .onReceive(Just(favoriteChanged)) { _ in
//                           // Fetch data again when favoriteChanged is toggled
//                            viewModel.favoriteIDs = favorites.saveItems
//                            viewModel.fetchData()
//                        }
                        .onReceive(Just(favoriteChanged)) { favoriteChangedValue in
                            if favoriteChangedValue {
                                // Fetch data again when favoriteChanged is toggled
                                viewModel.favoriteIDs = favorites.saveItems
                                viewModel.fetchData()
                            }
                        }
                    }.padding(.horizontal)
//                }
                
                Spacer()
            }
        }.fullScreenCover(isPresented: $isTap) {
            DetailBusRoute(nameRouteDetail: dataHolder.nameRouteDetail!)
        }
    }
}

struct TransitionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .animation(.easeInOut)
            .transition(.move(edge: .trailing)) // Set the transition to move from the trailing edge
    }
}

struct FavoriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteScreen()
    }
}
