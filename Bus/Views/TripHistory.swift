//
//  TripHistory.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 26/04/2024.
//

import SwiftUI

struct TripHistory: View {
    @ObservedObject var tripAPI = TripAPI()
    @EnvironmentObject var dataHolder: DataHolder
    @State private var isLoading = true
    
    var body: some View {
        VStack{
            BarBackCustom(back: "", color: .black, nameRoute: "Lịch sử chuyến đi").padding(.horizontal)
            HeightSpacer(heightSpacer: 10)
            ScrollView{
                VStack{
                    //                    ForEach(tripAPI.trip, id: \.id){ trip in
                    //                        let timeString = extractMonthYear(from: trip.date)
                    //                        TripHistoryRow(nameRoute: trip.dutySession.route.routeName, date: timeString, plateNumber: trip.dutySession.vehicle.plateNumber)
                    //                    }
                    
                    ForEach(1..<200){ trip in
                        Text("\(trip)")
                    }
                    
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
        }
            .onAppear{
//                tripAPI.getTripForUser(tokenLogin: dataHolder.tokenLogin)
            }
    }
    
    
    func extractMonthYear(from date: String) -> String {
        // Tạo một đối tượng Calendar
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: date) {
            // Tạo một đối tượng Calendar
            let calendar = Calendar.current
            
            // Trích xuất tháng và năm từ đối tượng Date
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            let hour = calendar.component(.hour, from: date)
            let min = calendar.component(.minute, from: date)
            let day = calendar.component(.day, from: date)
            
            // Tạo chuỗi tháng và năm
            let timeString = "\(hour):\(min) \(day)/\(month)/\(year)"
            
            return timeString
        } else {
            // Xử lý trường hợp không thể chuyển đổi chuỗi thành đối tượng Date
            return "Không thể phân tích chuỗi thời gian"
        }
    }
}

//
//struct TripHistory_Previews: PreviewProvider {
//    static var previews: some View {
//        TripHistory()
//    }
//}
