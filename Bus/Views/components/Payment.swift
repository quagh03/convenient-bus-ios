//
//  Payment.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct Payment: View {
    @ObservedObject var viewModel = LoginApi()
    @EnvironmentObject var dataHolder: DataHolder
    
    @State private var isPress: Bool = false
    @State var code: String = ""
    
    @State var isTap: Bool = false
    @State var isPaymentHistory: Bool = false
    
    @ObservedObject var userAPI = UserAPI()
    
    var body: some View {
        VStack{
            ZStack(){
                ReusableImage(color: "primary", height: 60,width: .infinity)
                Text("Thanh toán").foregroundColor(.white)
                    .bold()
                    .font(.system(size: 25))
            }.padding(.bottom,18)
            
            Rectangle()
                .frame(height: 101)
                .padding(.horizontal)
                .foregroundColor(.clear)
                .overlay{
                    Rectangle()
                        .stroke(Color.gray, lineWidth: 2).padding(.horizontal)
                }
                .overlay {
                    HStack{
                        VStack(alignment:.leading){
                            Text("Số dư của bạn:")
                            Text("")
                            HStack{
                                //                                Text( isPress ? "100000000": "********")
                                ZStack(alignment:.leading){
                                    Text("********")
                                        .opacity(isPress ? 0 : 1)
                                    Text(formatBalance())
                                        .opacity(isPress ? 1 : 0)
                                }
                                Button(action: {
                                    isPress.toggle()
                                }) {
                                    Image(systemName: "eye.fill").foregroundColor(.black)
                                        .padding(.leading,16)
                                }
                            }
                        }
                        // end VStack
                        WidthSpacer(widthSpacer: 12)
                        
                        // button nap tien
                        Button {
                            isTap = true
                        } label: {
                            ReusableImage(color: "primary", height: 50,width: 128)
                                .overlay{
                                    Text("Nạp tiền").foregroundColor(.white).font(.system(size: 20)).bold()
                                }
                        }
                        // end btn
                    }
                }
            // end overlay
            
            
            Rectangle().frame(width: 360, height: 360)
                .padding(.vertical)
                .foregroundColor(.white)
                .overlay{
                    Rectangle()
                        .stroke(.gray ,lineWidth: 1)
                        .frame(width: 360, height: 360)
                    
                }
                .overlay{
                    VStack{
                        HStack{
                            Text("Mã QR").padding(.horizontal)
                            Spacer()
                        }
                        AsyncImage(url: URL(string : code)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .foregroundColor(.gray)
                        }
                        .ignoresSafeArea()
                        .frame(width: 300, height: 300)
                        
                    }
                }
            
            
            // history
            Button {
                isPaymentHistory = true
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.clear)
                    .frame(height: 56)
                    .overlay{
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray,lineWidth: 1)
                    }
                    .overlay{
                        HStack{
                            Text("Lịch sử giao dịch").foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right").foregroundColor(.black)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                
            }
            
            
            
            Spacer()
        }
        .onAppear{
            fetchQRCode(token: dataHolder.tokenLogin)
            userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
        }
        .fullScreenCover(isPresented: $isTap) {
            Money()
        }
        .fullScreenCover(isPresented: $isPaymentHistory) {
            PaymentHistory()
        }
        /// end VStack
    }
    
    func formatBalance() -> String{
        if let balance = userAPI.balance {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 0 // Số lẻ sau dấu phẩy
            numberFormatter.minimumFractionDigits = 0 // Số lẻ sau dấu phẩy
            if let formattedBalance = numberFormatter.string(from: NSNumber(value: balance)) {
                return formattedBalance
            }
        }
        return "0"
        
    }
    
    func fetchQRCode(token: String){
        guard let url = URL(string: "http://localhost:8080/api/v1/users/QRCode") else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error fetching")
                return
            }
            
            do{
                let decodedResponse = try JSONDecoder().decode(QRCode.self, from: data)
                DispatchQueue.main.async {
                    self.code = decodedResponse.data
                    print(code)
                }
                
            } catch{
                print(error)
            }
        }.resume()
        
    }
}

