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
    @StateObject var transAPI = TransactionAPI()
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var userAPI = UserAPI()
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
//            Spacer()
            
            VStack{
                if transAPI.allTransactions.isEmpty {
                    VStack{
                        Text("Chưa có dữ liệu")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                    }.offset(y: 20)
                } else {
                    if selectedTab == 0 {
                        ScrollView{
                            ForEach(transAPI.allTransactions, id: \.id) {trans in
                                //                    PaymentHistoryRow(imgName: trans.status=="COMPLETED" ? "addCard": "minusCard", title: trans.type=="IN" ? "":"", time: <#T##String#>, amount: "\(trans.amount)", status: trans.status=="COMPLETED" ? "Thành công":"Thất bại")
                                let timeString = extractMonthYear(from: trans.time)
                                let moneyE = trans.amount/100
                                let moneyWithoutDecimal = Int(moneyE)
                                PaymentHistoryRow(imgName: trans.type == "IN" ? "addCard" : "minusCard",
                                                  title: trans.type == "IN" ? "Nạp tiền vào ví" : "Thanh toán vé \(timeString)",
                                                  time: timeString,
                                                  amount: trans.type == "IN" ? "\(moneyWithoutDecimal)" : "\(Int(trans.amount))",
                                                  status: trans.status == "COMPLETED" ? "Thành công" : "Thất bại",
                                                  color: trans.status == "COMPLETED" ? .green : .red)
                                .onTapGesture {
                                    dataHolder.time = timeString
                                    dataHolder.type = trans.type
                                    dataHolder.status = trans.status
                                    dataHolder.amount = trans.amount
                                    dataHolder.vnpID = trans.vnpID
                                    dataHolder.firstNamePH = trans.user.firstName
                                    dataHolder.lastNamePH = trans.user.lastName
                                    dataHolder.phoneNumberPH = trans.user.phoneNumber
                                    dataHolder.emailPH = trans.user.email
                                    isTap = true
                                }
                                
                            }
                        }
                    } else if selectedTab == 1 {
                        ScrollView{
                            ForEach(transAPI.inTrans, id:\.id){trans in
                                let timeString = extractMonthYear(from: trans.time)
                                let moneyE = trans.amount/100
                                let moneyWithoutDecimal = Int(moneyE)
                                PaymentHistoryRow(imgName: "addCard",
                                                  title: "Nạp tiền vào ví",
                                                  time: timeString,
                                                  amount: "\(moneyWithoutDecimal)",
                                                  status: trans.status == "COMPLETED" ? "Thành công" : "Thất bại",
                                                  color: trans.status == "COMPLETED" ? .green : .red)
                            }
                        }
                    } else if selectedTab == 2 {
                        ScrollView{
                            ForEach(transAPI.outTrans, id: \.id) {trans in
                                let timeString = extractMonthYear(from: trans.time)
                                let moneyWithoutDecimal = Int(trans.amount)
                                PaymentHistoryRow(imgName: "minusCard",
                                                  title: "Thanh toán vé \(timeString)",
                                                  time: timeString,
                                                  amount: "\(moneyWithoutDecimal)",
                                                  status: trans.status == "COMPLETED" ? "Thành công" : "Thất bại",
                                                  color: trans.status == "COMPLETED" ? .green : .red)
                                
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
        }.onAppear{
            Task{
                do{
                    try await userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
                }catch{
                    print("Error fetching user data: \(error)")
                }
               
            }
            transAPI.getAllTransaction(tokenLogin: dataHolder.tokenLogin, userId: dataHolder.idUser!)
        }
        .fullScreenCover(isPresented: $isTap) {
            DetailPaymentHistory(imgName: dataHolder.type == "IN" ? "addCard" : "minusCard",
                                 status: dataHolder.status == "COMPLETED" ? "Thành công" : "Thất bại",
                                 txtColor: dataHolder.status == "COMPLETED" ? .green : .red,
                                 vnpId: dataHolder.vnpID ?? "",
                                 time: dataHolder.time!,
                                 desc: dataHolder.type == "IN" ? "Nạp tiền vào ví" : "Thanh toán vé \(String(describing: dataHolder.time!))",
                                 userName: "\(dataHolder.lastNamePH!) \(dataHolder.firstNamePH!)",
                                 email: dataHolder.emailPH!, phone: dataHolder.phoneNumberPH!, amount: dataHolder.amount!)
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
