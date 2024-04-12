//
//  FavoriteScreen.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/04/2024.
//

import SwiftUI

struct FavoriteScreen: View {
    @EnvironmentObject private var favorites: Favotites
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var viewModel = BusRoutesApi()
    @State private var isTap: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    ReusableImage(color: "primary", height: 65, width: .infinity)
                    BarBackCustom(color: .white, nameRoute: "Yêu thích")
                }
                Spacer()
                ScrollView{
                    ForEach(viewModel.busRouteFavorite, id: \.id) { favorite in
                        RouteRow(busRoute: favorite)
                            .onTapGesture {
                                dataHolder.nameRouteDetail = favorite.routeName
                                isTap = true
                            }
                    }.onAppear{
                        viewModel.favoriteIDs = favorites.saveItems
                        viewModel.fetchData()
                    }
                }.padding(.horizontal)
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
