//
//  PaymentHistory.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 04/04/2024.
//

import SwiftUI
import SlidingTabView

struct PaymentHistory: View {
    @State private var selectedTab = 0
    @ObservedObject var transAPI = TransactionAPI()
    @ObservedObject var userAPI = UserAPI()
    @EnvironmentObject var dataHolder: DataHolder
    @State var isTap:Bool = false
    var body: some View {
        VStack{
            ZStack(){
                ReusableImage(color: "primary", height: 60,width: .infinity)
                Text("Lịch sử giao dịch").foregroundColor(.white)
                    .bold()
                    .font(.system(size: 25))
                BarBackCustom(back: "", color: .white, nameRoute: "").padding(.horizontal)
            }
            
            // sliding
            SlidingTabView(selection: $selectedTab, tabs: ["Tất cả", "Nạp Tiền","Thanh toán"], animation: .easeInOut, activeAccentColor: .blue, selectionBarColor: .blue)
            Spacer()
            
            VStack{
                if selectedTab == 0 {
                    ScrollView{
                        ForEach(transAPI.allTransactions, id: \.id) {trans in
                            //                    PaymentHistoryRow(imgName: trans.status=="COMPLETED" ? "addCard": "minusCard", title: trans.type=="IN" ? "":"", time: <#T##String#>, amount: "\(trans.amount)", status: trans.status=="COMPLETED" ? "Thành công":"Thất bại")
                            let timeString = extractMonthYear(from: trans.time)
                            PaymentHistoryRow(imgName: trans.type == "IN" ? "addCard" : "minusCard",
                                              title: trans.type == "IN" ? "Nạp tiền vào ví" : "Thanh toán vé \(timeString)",
                                              time: timeString,
                                              amount: "\(trans.amount)",
                                              status: trans.status == "COMPLETED" ? "Thành công" : "Thất bại",
                                              color: trans.status == "COMPLETED" ? .green : .red)
                            .onTapGesture {
                                isTap = true
                                
                            }
                            
                        }
                    }
                } else if selectedTab == 1 {
                    ScrollView{
                        ForEach(transAPI.inTrans, id:\.id){trans in
                            let timeString = extractMonthYear(from: trans.time)
                            PaymentHistoryRow(imgName: "addCard",
                                              title: "Nạp tiền vào ví",
                                              time: timeString,
                                              amount: "\(trans.amount)",
                                              status: trans.status == "COMPLETED" ? "Thành công" : "Thất bại",
                                              color: trans.status == "COMPLETED" ? .green : .red)
                        }
                    }
                } else if selectedTab == 2 {
                    ScrollView{
                        ForEach(transAPI.outTrans, id: \.id) {trans in
                            let timeString = extractMonthYear(from: trans.time)
                            PaymentHistoryRow(imgName: "minusCard",
                                              title: "Thanh toán vé \(timeString)",
                                              time: timeString,
                                              amount: "\(trans.amount)",
                                              status: trans.status == "COMPLETED" ? "Thành công" : "Thất bại",
                                              color: trans.status == "COMPLETED" ? .green : .red)
                            
                        }
                    }
                }
            }
            
        }.onAppear{
            userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
            DispatchQueue.main.asyncAfter(deadline: .now()+2){
                transAPI.getAllTransaction(tokenLogin: dataHolder.tokenLogin, userId: userAPI.id!)
            }
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
            
            // Tạo chuỗi tháng và năm
            let timeString = "\(hour):\(min) -\(month)/\(year)"
            
            return timeString
        } else {
            // Xử lý trường hợp không thể chuyển đổi chuỗi thành đối tượng Date
            return "Không thể phân tích chuỗi thời gian"
        }
    }


}

//struct PaymentHistory_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentHistory()
//    }
//}
