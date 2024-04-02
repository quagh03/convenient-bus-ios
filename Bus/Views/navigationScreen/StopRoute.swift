//
//  StopRoute.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 29/03/2024.
//

import SwiftUI

struct StopRoute: View {
    let busRouteDetailStopName: String
    
    var body: some View {
        CustomRowStopStatic(stopPoint: busRouteDetailStopName, isFirst: false)
    }
}
