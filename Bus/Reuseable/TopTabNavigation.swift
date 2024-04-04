//
//  TopTabNavigation.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/03/2024.
//

import SwiftUI

struct TopTabNavigation: View {
    @Binding var selectedTab: Int
    @Namespace private var buttonId
    private let selectionButton = ["Trạm dừng", "Thông tin"]
    
    var body: some View {
        HStack(alignment:.top){
            ForEach(selectionButton.indices, id:\.self) { index in
                VStack{
                    Button(selectionButton[index]) {
                        withAnimation {
                            selectedTab = index
                        }
                    }
                    .foregroundStyle(selectedTab == index ? .primary : .secondary)
                    .padding(.horizontal)

                    if selectedTab == index {
                        Capsule()
                            .frame(width: 80, height: 3)
                            .padding(.horizontal, 4)
                            .foregroundStyle(Color("primary"))
                            .matchedGeometryEffect(id: "ID", in: buttonId)
                    } else {
                        EmptyView()
                            .frame(height: 40)
                            .matchedGeometryEffect(id: "ID", in: buttonId)
                    }
                }.animation(.default, value: selectedTab)
            }
        }
        //end HStack
        
        
    }
}

struct TopTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        TopTabNavigation(selectedTab: .constant(1))
    }
}
