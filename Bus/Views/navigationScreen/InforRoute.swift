//
//  InforRoute.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 02/04/2024.
//

import SwiftUI

struct InforRoute: View {
//    var nameNumber:String
//    var nameRoute: String
//    var start_Point: String
//    var end_Point: String
//    var timeRoute: String
//    var priceTicket: String
    var infod : BusRouteDetail
    let size: CGFloat = 14
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment:.center){
                Text("Tuyến số:").font(.system(size: size))
                Spacer()
                Text(infod.routeId.routeName).font(.system(size: size))
            }.frame(maxWidth: .infinity)
                .padding(.vertical)
            //
            HStack(alignment:.center){
                Text("Tên tuyến:").font(.system(size: size))
                Spacer()
                Text("\(infod.startPoint.stopPoint)-\(infod.endPoint.stopPoint)").font(.system(size: size))
            }.frame(maxWidth: .infinity)
                .padding(.vertical)
            //
            HStack(alignment:.center){
                Text("Điểm xuất phát:").font(.system(size: size))
                Spacer()
                Text(infod.startPoint.stopPoint).font(.system(size: size))
            }.frame(maxWidth: .infinity)
                .padding(.vertical)
            //
            HStack(alignment:.center){
                Text("Điểm kết thúc:").font(.system(size: size))
                Spacer()
                Text(infod.endPoint.stopPoint).font(.system(size: size))
            }.frame(maxWidth: .infinity)
                .padding(.vertical)
            //
            HStack(alignment:.center){
                Text("Thời gian:").font(.system(size: size))
                Spacer()
                Text("5:00 - 22:00").font(.system(size: size))
            }.frame(maxWidth: .infinity)
                .padding(.vertical)
            //
            HStack(alignment:.center){
                Text("Giá vé:").font(.system(size: size))
                Spacer()
                Text("\(String(infod.routeId.price)) VND").font(.system(size: size))
            }.frame(maxWidth: .infinity)
                .padding(.vertical)
            
            
        }.frame(maxWidth: .infinity)
    }
}

//struct InforRoute_Previews: PreviewProvider {
//    static var previews: some View {
//        InforRoute(nameNumber: "E01", nameRoute: "Ben xe My Dinh - kdtsss", start_Point: "my dinh", end_Point: "Kdt ocent ", timeRoute: "11-22", priceTicket: "9.222", infod: <#BusRouteDetail#>)
//    }
//}
