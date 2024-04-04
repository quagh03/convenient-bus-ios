//
//  WidthSpacer.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 02/04/2024.
//

import SwiftUI

struct WidthSpacer: View {
    var widthSpacer: CGFloat
    var body: some View {
        Text("").padding(.horizontal,widthSpacer)
    }
}

struct WidthSpacer_Previews: PreviewProvider {
    static var previews: some View {
        WidthSpacer(widthSpacer: 2)
    }
}
