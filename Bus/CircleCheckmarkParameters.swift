//
//  CircleCheckmarkParameters.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 15/04/2024.
//

import Foundation
class CircleCheckmarkParameters: ObservableObject {
    @Published var showThumb: Int = 100
    @Published var drawRing: Float = 1/99
    @Published var showCircle: Int = 0
    @Published var showCheckmark: Int = -60
    @Published var rotateCheckmark: Int = 30
    
    func initialValues(){
        showThumb = 100
        drawRing = 1/99
        showCircle = 0
        rotateCheckmark = 30
        showCheckmark = -60
    }
    
    func updateParameters() {
            showThumb = 0
            drawRing = 1
            showCircle = 1
            rotateCheckmark = 0
            showCheckmark = 0
        }
}
