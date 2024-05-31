//
//  ToastM1.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 27/5/24.
//

import SwiftUI


struct ToastM1: View {
    @State private var animateIn: Bool = false
    @State private var animateOut: Bool = false
    // Properties
    @State var symbol: String?
    @State var tint: Color
    @State var title: String
    
//    @Binding var isShowing: Bool
    @State private var bottomPadding: CGFloat = 0

    var body: some View {
        ZStack(alignment: .top) {
            VStack(){
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
                .offset(y: animateIn ? 0 : -150)
                .offset(y: !animateOut ? 0 : 150)
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
                        }
    //                    removeToast()
                    }
                    
                }
                Spacer()
            }
        }.padding(.top, bottomPadding)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            // Đặt giá trị cho bottomPadding khi view được hiển thị
            if let window = UIApplication.shared.windows.first {
                bottomPadding = window.safeAreaInsets.bottom
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

#Preview {
    ToastM1(symbol: "checkmark", tint: .clear, title: "Hello world")
}
