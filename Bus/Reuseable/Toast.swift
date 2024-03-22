////
////  Toast.swift
////  Bus
////
////  Created by Nguyễn Hữu Hiếu on 19/03/2024.
////
//
import SwiftUI

enum ToastErrorType {
    case general(String)
    case emailInvalid(String)
    case passwordInvalid(String)
}


struct Toast: View {
    @State var text:String
    @State var isShowing: Bool
    @Binding var showToast: Bool

    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .padding()
                .background(Color("lightGray"))
                .foregroundColor(Color.black)
                .cornerRadius(15)
                .transition(.move(edge: .bottom))
                .opacity(1)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        withAnimation(.easeInOut) {
                            isShowing = false
                            showToast = false
                        }
                    }
                }
        }
        .padding(.bottom, 50)
        .onChange(of: isShowing, perform: { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut) {
                    showToast = false
                }
            }
        })

    }
}




struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast(text: "error", isShowing: false, showToast: .constant(true))
    }
}

