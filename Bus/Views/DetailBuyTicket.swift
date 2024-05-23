//
//  DetailBuyTicket.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 15/04/2024.
//

import SwiftUI
import Combine


struct DetailBuyTicket: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataHolder: DataHolder
    @ObservedObject var userAPI = UserAPI()
    @ObservedObject var transAPI = TransactionAPI()
    @ObservedObject var ticketAPI = TicketAPI()
    
    @State private var showingSuccessModal = false
    @State private var showingFailedModal = false
    @StateObject var circleParameters = CircleCheckmarkParameters()
    
    @Binding var isShowDetailBuyTicket: Bool
    
    @Binding var check: Bool
    @Binding var isReturn: Bool
    @State private var functionCompleted = false

    @State private var isBtnPress:Bool = false
    @State private var showProgressView = false

    
    let titleInfoIndi: [String] = ["Họ và tên", "Ngày sinh", "Email", "Số điện thoại"]
    let detailRegis: [String] = ["Thời gian đăng ký","Thời hạn"]
    let paymentInfo: [String] = ["Giá vé", "Thời hạn", "Tổng cộng"]
    
    var body: some View {
        ZStack{
            VStack{
                // header
                ZStack{
                    ReusableImage(color: "primary", height: 65, width: .infinity)
                    BarBackCustom(back: "", color: .white, nameRoute: "Chi tiết đăng ký").padding(.horizontal)
                }
                // info
                HeightSpacer(heightSpacer: 5)
                
                ScrollView{
                    // section 1
                    Section {
                        VStack{
                            ForEach(titleInfoIndi.indices, id:\.self){ index in
                                ProfileRow(title: titleInfoIndi[index], infor: userDataForTitleInfo(index))
                            }
                        }
                    } header: {
                        HStack{
                            Text("Thông tin khách hàng").foregroundColor(.black).bold()
                            Spacer()
                        }.padding(.horizontal)
                    }
                    
                    HeightSpacer(heightSpacer: 20)
                    
                    // section 2
                    Section {
                        VStack{
                            ForEach(detailRegis.indices, id:\.self){ index in
                                ProfileRow(title: detailRegis[index], infor: dataForDetailRegis(index))
                            }
                        }
                    } header: {
                        HStack{
                            Text("Chi tiết đăng ký").foregroundColor(.black).bold()
                            Spacer()
                        }.padding(.horizontal)
                    }
                    
                    HeightSpacer(heightSpacer: 20)
                    
                    // section 3
                    Section {
                        VStack{
                            ForEach(paymentInfo.indices, id:\.self){ index in
                                ProfileRow(title: paymentInfo[index], infor: dataForInfoPayment(index))
                            }
                        }
                    } header: {
                        HStack{
                            Text("Thông tin thanh toán").foregroundColor(.black).bold()
                            Spacer()
                        }.padding(.horizontal)
                    }
                    HStack{
                        Text("* Giá vé trên đã bao gồm thuế VAT").foregroundColor(.gray)
                        Spacer()
                    }.padding(.horizontal)
                    
                    // button payment
                    VStack{
                        HStack{
                            Text("Tổng cộng").bold()
                            Spacer()
                            Text("\(dataHolder.priceTicket! * dataHolder.numOfTicket!)").bold()
                        }.padding(.horizontal)
                        //                        dataHolder.isExistTicket ? "Gia hạn":
                        ReuseableButton(red: 96/255, green: 178/255, blue: 240/255, text: dataHolder.isExistTicket ? "Gia Hạn":"Mua vé", width: .infinity, imgName: "", textColor: .white) {
                            isBtnPress = true
                        }.padding(.bottom,15)
                        .padding(.horizontal)
                        .alert(isPresented: $isBtnPress) {
                            Alert(
                                title: Text("Xác nhận"),
                                message: dataHolder.isExistTicket ? Text("Bạn chắc chắn muốn gia hạn vé?") : Text("Bạn chắc chắn muốn mua vé?"),
                                primaryButton: .default(dataHolder.isExistTicket ? Text("Gia hạn") : Text("Mua vé")) {
                                    showProgressView = true
                                    handleAction()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }.padding(.vertical)
                }
                Spacer()
            }
            
            if showProgressView{
                    ProgressView()
            }
            
            if functionCompleted{
                if dataHolder.check1 {
                    AlertPaymentSuccess(isReturn: $isReturn).frame(maxWidth: .infinity).ignoresSafeArea()
                } else {
                    AlertPaymentFailed().frame(maxWidth: .infinity).ignoresSafeArea()
                }
            }
            
        }
        
    }
    
    func handleAction(){
//        if dataHolder.isExistTicket {
//            ticketAPI.exprireTiket(tokenLogin: dataHolder.tokenLogin, startDate: dataHolder.date!, periods: dataHolder.numOfTicket!, price: Double(dataHolder.priceTicket!))
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
//                dataHolder.check1 = ticketAPI.isExpireTicket!
//            }
//            
//        } else {
//            transAPI.deposit(tokenLogin: dataHolder.tokenLogin, startDate: dataHolder.date!, periods: dataHolder.numOfTicket!, price: Double(dataHolder.priceTicket! * dataHolder.numOfTicket!))
//        }
//        
//        check = true
//        showProgressView = false
//        functionCompleted = true
        Task {
            if dataHolder.isExistTicket {
                try await ticketAPI.exprireTiket(tokenLogin: dataHolder.tokenLogin, startDate: dataHolder.date!, periods: dataHolder.numOfTicket!, price: Double(dataHolder.priceTicket!))
//                try await ticketAPI.expireTicket(tokenLogin: dataHolder.tokenLogin, startDate: dataHolder.date!, periods: dataHolder.numOfTicket!, price: Double(dataHolder.priceTicket!))
                dataHolder.check1 = ticketAPI.isExpireTicket ?? false
            } else {
                try await transAPI.deposit(tokenLogin: dataHolder.tokenLogin, startDate: dataHolder.date!, periods: dataHolder.numOfTicket!, price: Double(dataHolder.priceTicket! * dataHolder.numOfTicket!))
            }
            
            showProgressView = false
            functionCompleted = true
        }
    }
    
    func isShowDetailToggle(){
        isShowDetailBuyTicket = false
    }
    
    // titleInfoIndi
    func userDataForTitleInfo(_ index: Int) -> String {
        switch titleInfoIndi[index]{
        case "Họ và tên":
            return ("\(dataHolder.lNameUser ?? "") \(dataHolder.fNameUser ?? "")")
        case "Ngày sinh":
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

            if let dateString = dataHolder.dobUser {
                if let dob = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = "yyyy/MM/dd"
                    return dateFormatter.string(from: dob)
                }
            }
            return ""
        case "Email":
            return dataHolder.emailUser ?? ""
        case "Số điện thoại":
            return dataHolder.phoneUser ?? ""
        default:
            return ""
        }

    }
    
    // detailRegis
    func dataForDetailRegis(_ index: Int) -> String {
        switch detailRegis[index]{
        case "Thời gian đăng ký":
            return dataHolder.date!
        case "Thời hạn":
            return "\(String(describing: dataHolder.numOfTicket!))"
        default:
            return ""
        }
    }
    
    // infoPayment
    func dataForInfoPayment(_ index: Int) -> String {
        switch paymentInfo[index]{
        case "Giá vé":
            return String(describing: dataHolder.priceTicket!)
        case "Thời hạn":
            return String(describing: dataHolder.numOfTicket!)
        case "Tổng cộng":
            let total: Int = dataHolder.priceTicket! * dataHolder.numOfTicket!
            return String(describing: (total))
        default:
            return ""
        }
    }
    
}

//struct DetailBuyTicket_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailBuyTicket()
//    }
//}
