//
//  CustomCircleCheckmark.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 15/04/2024.
//

import SwiftUI

struct CustomCircleCheckmark: View {
    @State  var showThumb = 100
    @State  var drawRing = 1/99
    @State  var showCircle = 0
    @State  var showCheckmark = -60
    @State  var rotateCheckmark = 30
    @ObservedObject var parameters: CircleCheckmarkParameters
    
    var body: some View {
//        VStack{
//            ZStack{
//                // inactive
//                Circle()
//                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
//                    .frame(width: 126,height: 126, alignment: .center)
//                    .foregroundColor(.gray)
//
//                // active
//                Circle().trim(from: 0,to: CGFloat(drawRing))
//                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
//                    .frame(width: 126,height: 126, alignment: .center)
//                    .rotationEffect(.degrees(-90))
//                    .foregroundColor(.green)
//                    .animation(Animation.easeInOut(duration: 1).delay(1))
//
//                // green
//                Circle()
//                    .frame(width: 110, height: 110, alignment: .center)
//                    .foregroundColor(.green)
//                    .scaleEffect(CGFloat(showCircle))
//                    .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(2))
//
//                Image(systemName: "checkmark").font(.system(size: 60))
//                    .foregroundColor(.white)
//                    .clipShape(Rectangle().offset(x: CGFloat(showCheckmark)))
//                    .rotationEffect(.degrees(Double(rotateCheckmark)))
//                    .animation(Animation.interpolatingSpring(stiffness: 180, damping: 15).delay(2.5))
//            }
//
////                showThumb = 0
////                drawRing = 1
////                showCircle = 1
////                rotateCheckmark = 0
////                showCheckmark = 0
//
//        }
        
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
                           .foregroundColor(.green)
                           .animation(Animation.easeInOut(duration: 1).delay(0.3))
                       
                       // green
                       Circle()
                           .frame(width: 110, height: 110, alignment: .center)
                           .foregroundColor(.green)
                           .scaleEffect(CGFloat(parameters.showCircle))
                           .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(1))
                       
                       Image(systemName: "checkmark").font(.system(size: 60))
                           .foregroundColor(.white)
                           .clipShape(Rectangle().offset(x: CGFloat(parameters.showCheckmark)))
                           .rotationEffect(.degrees(Double(parameters.rotateCheckmark)))
                           .animation(Animation.interpolatingSpring(stiffness: 180, damping: 15).delay(2))
                   }
                   
               }
    }
}

struct CustomCircleCheckmark_Previews: PreviewProvider {
    static var previews: some View {
//        CustomCircleCheckmark(showThumb: 0, drawRing: 1, showCircle: 1, showCheckmark: 0, rotateCheckmark: 0)
        CustomCircleCheckmark(parameters: CircleCheckmarkParameters())
    }
}
