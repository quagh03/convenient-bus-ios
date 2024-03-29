//
//  ReusableImage.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct ReusableImage: View {
    var color: String
    var height: CGFloat
    var body: some View {
        Rectangle()
            .foregroundColor(Color(color))
            .frame(height: height)
//            .ignoresSafeArea()
    }
}

struct ReusableImage_Previews: PreviewProvider {
    static var previews: some View {
        ReusableImage(color: "primary100",height: 200)
    }
}
