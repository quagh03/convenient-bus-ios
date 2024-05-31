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
    @State var addTripSuccess:Bool = false
    
    var body: some View {
        VStack{
            BarBackCustom(back: "", color: .black, nameRoute: "Lịch sử chuyến đi").padding(.horizontal)
            HeightSpacer(heightSpacer: 10)
            ScrollView{
                if tripAPI.trip.isEmpty{
                    VStack{
                        Text("Chưa có dữ liệu")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                    }.offset(y: 20)
                }else {
                    if tripAPI.isLoad {
                        ProgressView() // Hiển thị hình ảnh hoặc vòng quay tải khi đang tải mã QR
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    } else {
                        VStack{
                            ForEach(groupedTrips, id: \.0) { month, tripsInMonth in
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(month)
                                        .font(.headline)
                                        .padding(.leading)
                                    ForEach(tripsInMonth.sorted(by: { $0.date > $1.date }), id: \.id) { trip in
                                        let timeString = extractMonthYear(from: trip.date)
                                        TripHistoryRow(nameRoute: trip.dutySession.route.routeName, date: timeString, plateNumber: trip.dutySession.vehicle.plateNumber)
                                    }
                                }
                            }
                            Spacer()
                        }.frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .onAppear{
            tripAPI.getTripForUser(tokenLogin: dataHolder.tokenLogin)

        }
        .onChange(of: addTripSuccess) { newValue in
            if newValue {
                tripAPI.getTripForUser(tokenLogin: dataHolder.tokenLogin)
            }
            addTripSuccess = false
        }
    }
    
    var groupedTrips: [(String, [Trip])] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let tripsByMonth = Dictionary(grouping: tripAPI.trip) { trip in
            let date = dateFormatter.date(from: trip.date)!
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            return "Tháng \(month) - \(year)"
        }
        
        return tripsByMonth.sorted { $0.key > $1.key }
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
