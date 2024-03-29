//
//  Route.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct Route: View {
    @ObservedObject var viewModel = BusRoutesApi()
    var body: some View {
        VStack{
            ZStack(){
                ReusableImage(color: "primary", height: 60)
                Text("Tuyến xe").foregroundColor(.white)
                    .bold()
                    .font(.system(size: 25))
            }
            ReusableSearchbar(searchKey: "")
//                .offset(y:-80)
                .padding(.horizontal)
            
//            List(viewModel.busRoutes, id: \.id){ route in
//                RouteRow(busRoute: route)
//            }.onAppear{
//                viewModel.fetchData()
//            }
            
            
            ScrollView {
                VStack {
                    ForEach(viewModel.busRoutes, id: \.id) { route in
                        RouteRow(busRoute: route)
                    }
                }
            }
//            .offset(y:-80)
            .padding(.all)
            .onAppear {
                viewModel.fetchData()
            }



            Spacer()
         // end VStack 1
        }
    }
}

struct Route_Previews: PreviewProvider {
    static var previews: some View {
        Route()
    }
}
