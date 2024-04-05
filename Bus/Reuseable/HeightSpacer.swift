//
//  WidthSpacer.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 02/04/2024.
//

import SwiftUI

struct HeightSpacer: View {
    var heightSpacer: CGFloat
    var body: some View {
        Text("").frame(height: heightSpacer)
    }
}

struct HeightSpacer_Previews: PreviewProvider {
    static var previews: some View {
        WidthSpacer(widthSpacer: 2)
    }
}
