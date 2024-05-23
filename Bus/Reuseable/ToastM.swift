////
////  Toast.swift
////  Bus
////
////  Created by Nguyễn Hữu Hiếu on 19/03/2024.
////
//
import SwiftUI

enum ToastDuration {
    case short
    case medium
    case long
    
    var timeInterval: TimeInterval {
        switch self {
        case .short:
            return 1.0 // Thời gian ngắn: 1 giây
        case .medium:
            return 2.0 // Thời gian trung bình: 2 giây
        case .long:
            return 3.5 // Thời gian dài: 3.5 giây
        }
    }
}


struct ToastM: View {
    @State private var animateIn: Bool = false
    @State private var animateOut: Bool = false
    // Properties
    @State var symbol: String?
    @State var tint: Color
    @State var title: String
    
//    @Binding var isShowing: Bool
    

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(){
                Spacer()
                HStack{
                    if let symbol = symbol {
                        Image(systemName: symbol)
                            .font(.title)
                            .padding(.trailing, 10)
                    }
                    Text(title)
                }
    //            .foregroundColor()
                .padding(.horizontal,15)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(.background)
                        .shadow(color: Color.primary.opacity(0.06), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.primary.opacity(0.06), radius: 8, x: -5, y: -5)
                )
                .contentShape(Capsule())
                .offset(y: animateIn ? 0 : 150)
                .offset(y: !animateOut ? 0 : -150)
//                .offset(y: isShowing ? 0 : 150)
//                .offset(y: !isShowing ? 0 : -150)
                .task {
                    withAnimation {
                        animateIn = true
//                        isShowing = true
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + ToastDuration.medium.timeInterval) {
                        withAnimation {
                            animateIn = false
//                            isShowing = false
                        }
    //                    removeToast()
                    }
                    
                }
            }
        }
    }
    
    // remove toast
    func removeToast(){
//        animateIn = false
        withAnimation {
            animateOut = true
        }
    }
    
}


struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        ToastM(symbol: "airpods.gen3", tint: .clear, title: "Hello world")
    }
}

