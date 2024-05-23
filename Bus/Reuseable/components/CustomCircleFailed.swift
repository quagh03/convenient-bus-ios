//
//  CustomCircleFailed.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 16/04/2024.
//

import SwiftUI

struct CustomCircleFailed: View {
    @State  var showThumb = 100
    @State  var drawRing = 1/99
    @State  var showCircle = 0
    @State  var showCheckmark = -60
    @State  var rotateCheckmark = 30
    @ObservedObject var parameters: CircleCheckmarkParameters
    
    
    var body: some View {
        VStack{
                   ZStack{
                       // inactive
                       Circle()
                           .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                           .frame(width: 126,height: 126, alignment: .center)
                           .foregroundColor(.gray)
                       
                       // active
                       Circle().trim(from: 0,to: CGFloat(parameters.drawRing))
                           .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                           .frame(width: 126,height: 126, alignment: .center)
                           .rotationEffect(.degrees(-90))
                           .foregroundColor(.red)
                           .animation(Animation.easeInOut(duration: 1).delay(0.6))
                       
                       // green
                       Circle()
                           .frame(width: 110, height: 110, alignment: .center)
                           .foregroundColor(.red)
                           .scaleEffect(CGFloat(parameters.showCircle))
                           .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(1))
                       
                       Image(systemName: "xmark").font(.system(size: 60))
                           .foregroundColor(.white)
                           .clipShape(Rectangle().offset(x: CGFloat(parameters.showCheckmark)))
                           .rotationEffect(.degrees(Double(parameters.rotateCheckmark)))
                           .animation(Animation.interpolatingSpring(stiffness: 180, damping: 15).delay(2))
                   }
                   
               }
    }
}

struct CustomCircleFailed_Previews: PreviewProvider {
    static var previews: some View {
        CustomCircleFailed(parameters: CircleCheckmarkParameters())
    }
}
