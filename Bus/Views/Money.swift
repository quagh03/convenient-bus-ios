//
//  Money.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 04/04/2024.
//

import SwiftUI
import Combine
import SafariServices
import WebKit

struct Money: View {
    var placeholder: String = "Nhập số tiền muốn nạp"
    @State  var money: Float = 0
    @State var isChoose: Bool = true
    @State private var moneyText: String = ""
    @State private var isEditing: Bool = false
    @State private var keyboardHeight: CGFloat = 0.0
    
    @State private var webViewURL: URL? = nil
    @State private var isShowingWebView: Bool = false
    
    //    @ObservedObject var viewModel = VNPayApi()
    @EnvironmentObject var dataHolder: DataHolder
    
    @State private var urlVnPayUrl: String = ""
    
    
    //    let amounts: [Float] = [20000, 50000, 100000, 200000, 300000, 500000]
    let amounts: [String] = ["20000", "50000", "100000", "200000", "300000", "500000"]
    var body: some View {
        ZStack{
            VStack{
                // retangle
                ZStack(alignment:.top){
                    Rectangle()
                        .frame(height: 158)
                        .foregroundColor(Color("primary"))
                        .clipShape(RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 20))
                    BarBackCustom(color: .white ,nameRoute: "Nạp tiền").padding(.horizontal).padding(.top)
                    
                    
                    // Form nạp tiền
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
                                        VStack{
                                            Group{
                                                HStack{
                                                    Text("Số dư của bạn: ")
                                                    Spacer()
                                                    Text("0 VND")
                                                }
                                            }.font(.system(size: 22))
                                                .padding(.top)
                                            // input
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(.clear)
                                                .frame(height: 58)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(.black, lineWidth: 1)
                                                        .frame(height: 58)
                                                )
                                                .overlay{
                                                    TextField(placeholder, text: $moneyText)

                                                    
                                                    .keyboardType(.numberPad).padding(.horizontal)
                                                    .font(.system(size: 25))
                                                }
                                            
                                            // denomination
                                            VStack {
                                                HStack {
                                                    ForEach(amounts.indices.prefix(3)) { index in
                                                        Button {
                                                            self.moneyText = self.amounts[index]
                                                        } label: {
                                                            //                                                            Denomination(money: formatCurrency(amount: amounts[index]))
                                                            Denomination(money: amounts[index])
                                                        }.padding(.horizontal,7)
                                                    }
                                                }.padding(.vertical,10)
                                                HStack {
                                                    ForEach(amounts.indices.dropFirst(3)) { index in
                                                        Button {
                                                            self.moneyText = self.amounts[index]
                                                        } label: {
                                                            //                                                            Denomination(money: formatCurrency(amount: amounts[index]))
                                                            Denomination(money: amounts[index])
                                                        }.padding(.horizontal,7)
                                                    }
                                                }
                                            }
                                            
                                            // payment method
                                            HStack{
                                                Text("Phương thức thanh toán").font(.system(size: 22)).bold().padding(.vertical,5)
                                                Spacer()
                                            }.padding(.vertical,2)
                                            
                                            // vnpay
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(.clear)
                                                .frame(height: 60)
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(.gray, lineWidth: 1)
                                                }
                                                .overlay{
                                                    Button(action: {
                                                        isChoose.toggle()
                                                    }){
                                                        HStack{
                                                            Text("Nạp tiền qua").font(.system(size: 20))
                                                            WidthSpacer(widthSpacer: 2)
                                                            Image("vnpay").resizable()
                                                                .frame(width:122,height: 22)
                                                                .scaledToFit()
                                                            Spacer()
                                                            
                                                            //
                                                            Rectangle()
                                                                .fill(.clear)
                                                                .frame(width: 20,height: 20)
                                                                .clipShape(Circle())
                                                                .overlay{
                                                                    Circle()
                                                                        .stroke(Color.black, lineWidth: 1)
                                                                    
                                                                }
                                                                .overlay{
                                                                    Circle()
                                                                        .fill(isChoose ? Color("primary") : .clear)
                                                                        .frame(height: 15)
                                                                }
                                                        }.padding(.horizontal)
                                                        
                                                    }.foregroundColor(.black)
                                                }
                                            Spacer()
                                            
                                            // btn nap tien
                                            ReuseableButton(red: 96/255, green: 178/255, blue: 240/255, text: "Nạp tiền", width: .infinity, imgName: "", textColor: .white) {
                                                if let amount = Int(moneyText){
                                                    submitOrder(amount: amount, orderInfo: "")
                                                               
                                                }else{
                                                    print("Invalid amount")
                                                }
                                            }.padding(.bottom,10)
                                            
                                            
                                        }
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        
                                    }.frame(maxWidth: 365 ,maxHeight: .infinity)
                                    // end Vstack 1 overlay
                                    
                                }
                        }
                    }.padding(.top, 100)
                    // end form
                }
                Spacer()
            }
            // end VStack
            if isShowingWebView {
                           WebView(url: webViewURL!)
                               .edgesIgnoringSafeArea(.all)
                       }
        }

        .onReceive(Publishers.keyboardHeight) { keyboardHeight in
            self.keyboardHeight = keyboardHeight
        }
        .sheet(isPresented: $isShowingWebView) {
            if let webViewURL = webViewURL {
                WebView(url: webViewURL)
            }
        }
        
    }
    
    
    func submitOrder(amount: Int, orderInfo: String) {
        
        guard let url = URL(string: "http://localhost:8080/api/v1/vnpay/submitOrder?amount=\(amount*100)&orderInfo=\(orderInfo)") else {
            print("Invalid URL")
            return
        }
        
        // Tạo yêu cầu URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Hoặc POST, PUT, DELETE tùy vào yêu cầu của bạn
        request.setValue("Bearer \(dataHolder.tokenLogin)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                print("Error fetching")
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode(QRCode.self, from: data)
                DispatchQueue.main.async {
                    self.urlVnPayUrl = decodedData.data
                    if let url = URL(string: urlVnPayUrl){
                        self.webViewURL = url
                        self.isShowingWebView = true
//                        UIApplication.shared.open(url)
                    }
                    
                }
            } catch{
                print(String(describing: error))
            }
            
            
        }.resume()
    }
    
    
}
    

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Do nothing
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
            .map { $0.height }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

func formatCurrency(amount: Float) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    formatter.decimalSeparator = ","
    formatter.currencySymbol = ""
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: amount)) ?? ""
}


struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct Money_Previews: PreviewProvider {
    static var previews: some View {
        Money()
    }
}
