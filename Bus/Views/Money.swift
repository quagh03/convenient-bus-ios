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
    @State private var isLoadingWebView: Bool = false
    @State private var webViewNavigated: Bool = false
    
    //    @ObservedObject var viewModel = VNPayApi()
    @EnvironmentObject var dataHolder: DataHolder
    
    @State private var urlVnPayUrl: String = ""
    @ObservedObject var userAPI = UserAPI()
    
    
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
                    BarBackCustom(back: "",color: .white ,nameRoute: "Nạp tiền").padding(.horizontal).padding(.top)
                    
                    
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
                                                    Text("\(formatBalance()) VND")
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
//            if isShowingWebView {
//                WebView(url: webViewURL!, onClose: {
//                    userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
//                })
//                    .edgesIgnoringSafeArea(.all)
//            }
        }
        .onAppear{
            userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
        }
        .onReceive(Publishers.keyboardHeight) { keyboardHeight in
            self.keyboardHeight = keyboardHeight
        }
        .sheet(isPresented: $isShowingWebView) {
//            if self.isLoadingWebView { // Kiểm tra xem có đang tải không
//                ProgressView() // Hiển thị thanh tiến trình trong khi đang tải
//            } else {
//                WebView(url: dataHolder.webViewUrl!){
//                        userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
//                    }
//            }
            VStack {
                WebView(url: dataHolder.webViewUrl!, webViewNavigated: $webViewNavigated) {
                    userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
                }
                if webViewNavigated{
                    Button("Quay lại") {
                        self.isShowingWebView = false
                        userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
                    }
                }
            }
        }
        
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

    
    
    func submitOrder(amount: Int, orderInfo: String) {
        
        guard let url = URL(string: "http://localhost:8080/api/v1/vnpay/submitOrder?amount=\(amount*100)&orderInfo=\(orderInfo)") else {
            print("Invalid URL")
            return
        }
        
        self.isLoadingWebView = true
        
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
                        self.isLoadingWebView = false
                        dataHolder.webViewUrl = url
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
    let webViewNavigated: Binding<Bool>
    let onClose: ()->Void
    
    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
       return Coordinator(parent: self)
   }
    
    class Coordinator: NSObject, WKNavigationDelegate {
            let parent: WebView

            init(parent: WebView) {
                self.parent = parent
            }

            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                // Đã tải xong, có thể hiển thị WebView
                let urlString = webView.url?.absoluteString ?? ""
                           if urlString.contains("status") {
                               parent.webViewNavigated.wrappedValue = true // Đặt webViewNavigated thành true
                           }
            }

            func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
                // Lỗi khi tải WebView
            }

            func webViewDidClose(_ webView: WKWebView) {
                // WebView đã đóng
                parent.onClose() // Gọi callback để thông báo rằng WebView đã đóng
            }
        }
}

class WebViewDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let urlString = webView.url?.absoluteString ?? ""
        if urlString.contains("status") {
            // WebView đã chuyển hướng đến trang thông báo thành công của VNPay
            // Đặt biến webViewNavigated thành true
            // Để sử dụng biến webViewNavigated, bạn cần chuyển Money view sang class
            // hoặc sử dụng một @ObservedObject hoặc @StateObject để lưu trạng thái
            // trong một class ObservableObject khác
            
            
        }
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


//struct Money_Previews: PreviewProvider {
//    static var previews: some View {
//        Money()
//    }
//}
