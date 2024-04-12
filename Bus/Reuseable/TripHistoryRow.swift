//
//  TripHistory.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 11/04/2024.
//

import SwiftUI

struct TripHistoryRow: View {
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text("Tuyến xe")
                    Text("Thời gian")
                    Text("Biển số xe")
                }
                Spacer()
                VStack(alignment: .leading, spacing: 10){
                    Text("E01")
                    Text("9:05 -  28/03/2024")
                    Text("30A-000.01")
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
        TripHistoryRow()
    }
}
