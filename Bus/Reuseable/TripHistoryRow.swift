//
//  TripHistory.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 11/04/2024.
//

import SwiftUI

struct TripHistoryRow: View {
    @State var nameRoute: String
    @State var date: String
    @State var plateNumber: String
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text("Tuyến xe")
                    Text("Thời gian")
                    Text("Biển số xe")
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 10){
                    Text(nameRoute)
                    Text(date)
                    Text(plateNumber)
                }
            }.padding()
                .overlay {
                    Rectangle()
                        .stroke(Color("lightGray"), lineWidth: 1)
                }
        }
    }
}

struct TripHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        TripHistoryRow(nameRoute: "E01", date: "2222", plateNumber: "232103")
    }
}
