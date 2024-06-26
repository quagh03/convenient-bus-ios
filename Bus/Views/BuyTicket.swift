//
//  BuyTicket.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 05/04/2024.
//

import SwiftUI
import Combine

struct BuyTicket: View {
    @EnvironmentObject var dataHolder: DataHolder
    
    @State private var isDetailBuyTicketVisible = true
    @State  var priceTicket: Int = 100000
    @State  var numOfTicket: Int = 1
    
    @State var isPressed: Bool = false
    
    @State private var pressedTime: Date?
    @ObservedObject var ticketApi = TicketAPI()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @State var isTest: Bool = false
    
    @State private var check:Bool = false
    @State private var isReturn:Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                ZStack(alignment:.top){
                    Rectangle()
                        .frame(height: 158)
                        .foregroundColor(Color("primary"))
                        .clipShape(RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 20))
                    BarBackCustom(back: "" ,color: .white ,nameRoute: "Đăng ký vé tháng").padding(.horizontal).padding(.top)
                    
                    // vstack
                    VStack{
                        VStack{
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.white)
                                .padding(.horizontal)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(.gray, lineWidth: 1)
                                        .frame(maxWidth: 365)
                                }
                                .overlay{
                                    VStack{
                                        HStack(alignment: .center){
                                            ReusableFunc(imageName: "ticket", text: "")
                                                .padding(.all)
                                                .foregroundColor(.black)
                                            //
                                            VStack(alignment: .leading, spacing: 5){
                                                Text("Vé tháng liên tuyến").bold().font(.system(size: 20))
                                                Text("Thời hạn: 1 tháng").font(.system(size: 15)).foregroundColor(.black)
                                            }
                                            Spacer()
                                            
                                        }.padding(.horizontal)
                                        // end HStack
//                                        formattedRemainingTime(startDate: ticket.startDate,endDate: ticket.endDate)
                                        
                                        HStack{
                                            if let userDob = dataHolder.dobUser, let age = calculateAge(from: userDob){
                                                if age >= 60 {
                                                    Text("Bạn đã có vé")
                                                } else {
                                                    if dataHolder.isExistTicket {
                                                        ForEach(ticketApi.ticketForUser, id:\.id){ ticket in
                                                            let timeString = extractMonthYear(from: ticket.endDate)
                                                            Text("Vé tháng của bạn còn hạn đến: \(timeString)" ).foregroundColor(.gray)
                                                        }
                                                    } else {
                                                        Text("Bạn chưa có vé tháng!").foregroundColor(.gray)
                                                    }
                                                    
                                                }
                                            } else {
                                                EmptyView()
                                            }
                                            Spacer()
                                        }.padding(.horizontal)
                                        
                                        // line
                                        DottedLine().frame(height: 5 )
                                        
                                        // table
                                        Rectangle()
                                            .fill(.clear)
                                            .frame(width: 365)
                                            .overlay{
                                                VStack{
                                                    // title
                                                    RoundedRectangle(cornerRadius: 2).fill(Color("primary"))
                                                        .frame(height: 52)
                                                        .overlay{
                                                            VStack{
                                                                HStack {
                                                                    // Tiêu đề của các cột
                                                                    Text("Loại").fontWeight(.bold)
                                                                        .frame(maxWidth: .infinity)
                                                                        .padding(8)
                                                                        .foregroundColor(.white)
                                                                    Text("Giá").fontWeight(.bold)
                                                                        .frame(maxWidth: .infinity)
                                                                        .padding(8)
                                                                        .foregroundColor(.white)
                                                                    Text("Thời hạn").fontWeight(.bold)
                                                                        .frame(maxWidth: .infinity)
                                                                        .padding(8)
                                                                        .foregroundColor(.white)
                                                                }
                                                                // data
                                                            }
                                                        }
                                                    // data
                                                    RoundedRectangle(cornerRadius: 2).fill(.clear)
                                                        .frame(height: 52)
                                                        .overlay{
                                                            HStack {
                                                                // Tiêu đề của các cột
                                                                Text("Vé liên tuyến")
                                                                    .frame(maxWidth: .infinity)
                                                                    .padding(8)
                                                                Text("\(priceTicket)")
                                                                    .frame(maxWidth: .infinity)
                                                                    .padding(8)
                                                                Picker("", selection: $numOfTicket) {
                                                                    ForEach(1..<7) { number in
                                                                        Text("\(number) tháng")
                                                                            .tag(number)
                                                                    }
                                                                }
                                                                .frame(maxWidth: .infinity)
                                                            }
                                                        }
                                                    Spacer()
                                                    
                                                }
                                                
                                            }
                                        // end table
                                        Spacer()
                                        HStack(alignment: .top){
                                            Text("*Thời hạn của vé bắt đầu từ ngày đăng ký").foregroundColor(.red)
                                        }
                                        
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 365, height: 1)
                                        
                                        // pay
                                        HStack{
                                            Text("Tổng cộng").bold()
                                            Spacer()
                                            Text("\(priceTicket*numOfTicket)").bold()
                                        }.padding(.horizontal)
                                            .padding(.bottom,10)
                                            .frame(maxWidth: 365)
                                        
                                        ReuseableButton(red: 96/255, green: 178/255, blue: 240/255, text: "Tiếp tục", width: .infinity, imgName: "", textColor: .white) {
                                            self.pressedTime = Date()
                                            saveInfo()
                                            
                                        }.padding(.bottom,15)
                                            .padding(.horizontal)
                                        
                                    }
                                    .frame(maxWidth: 365 ,maxHeight: .infinity)
                                }
                            // end overlay
                            
                        }
                    }
                    .padding(.top,80)
                    // end form
                    
                    Spacer()
                }
                // end ZStack
            }
        }
        .onAppear{
            Task{
                do{
                    try await ticketApi.getAllTicket(tokenLogin: dataHolder.tokenLogin, userID: dataHolder.idUser!)
                    DispatchQueue.main.async{
                        dataHolder.isExistTicket = ticketApi.isExist
                    }
                }catch{
                    print("Error fetching user data: \(error)")
                }
               
            }
//            ticketApi.getAllTicket(tokenLogin: dataHolder.tokenLogin, userID: dataHolder.idUser!)
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
//                dataHolder.isExistTicket = ticketApi.isExist
//            }
        }
        .onReceive(Just(isReturn)){ success in
            if success {
                Task{
                    do{
                        try await ticketApi.getAllTicket(tokenLogin: dataHolder.tokenLogin, userID: dataHolder.idUser!)
                        DispatchQueue.main.async{
                            dataHolder.isExistTicket = ticketApi.isExist
                        }
                    }catch{
                        print("Error fetching user data: \(error)")
                    }
                   
                }
            }
            isReturn = false
        }
        .fullScreenCover(isPresented: $isPressed) {
            if isDetailBuyTicketVisible {
                DetailBuyTicket(isShowDetailBuyTicket: $isDetailBuyTicketVisible, check: $check, isReturn: $isReturn)
            }
        }
        // end
    }
    
    // saveInfo
    func saveInfo(){
        dataHolder.priceTicket = priceTicket
        dataHolder.numOfTicket = numOfTicket
        dataHolder.date = dateFormatter.string(from: pressedTime!)
        dataHolder.date1 = pressedTime!
        
        isPressed = true
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
//            let hour = calendar.component(.hour, from: date)
//            let min = calendar.component(.minute, from: date)
            let day = calendar.component(.day, from: date)
            
            // Tạo chuỗi tháng và năm
            let timeString = "\(day)/\(month)/\(year)"
            
            return timeString
        } else {
            // Xử lý trường hợp không thể chuyển đổi chuỗi thành đối tượng Date
            return "Không thể phân tích chuỗi thời gian"
        }
    }
    
    func calculateAge(from dateString: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: dateString) {
            let now = Date()
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: date, to: now)
            return ageComponents.year
        }
        return nil
    }
}

struct DottedLine: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let spacing: CGFloat = 5
                let dashedLength: CGFloat = 5
                let numberOfSegments = Int((geometry.size.width + dashedLength) / (spacing + dashedLength))
                let totalLength = CGFloat(numberOfSegments) * (spacing + dashedLength) - dashedLength
                
                let startX = (geometry.size.width - totalLength) / 2.0
                path.move(to: CGPoint(x: startX, y: 0))
                
                for index in 0..<numberOfSegments {
                    let x = startX + CGFloat(index) * (spacing + dashedLength)
                    path.addLine(to: CGPoint(x: x, y: 0))
                    path.move(to: CGPoint(x: x + dashedLength, y: 0))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
            .foregroundColor(Color("primary"))
            .frame(height: 1)
        }
    }
}



//struct BuyTicket_Previews: PreviewProvider {
//    static var previews: some View {
//        BuyTicket()
//    }
//}
