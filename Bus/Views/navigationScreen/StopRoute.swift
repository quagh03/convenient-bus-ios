//
//  StopRoute.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 29/03/2024.
//

import SwiftUI

struct StopRoute: View {
    var body: some View {
        VStack{
            ForEach(1..<4, id: \.self){index in
                CustomRowStopStatic(isFirst: index==1)
            }
        }
    }
}

struct StopRoute_Previews: PreviewProvider {
    static var previews: some View {
        StopRoute()
    }
}
