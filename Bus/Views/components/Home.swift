//
//  Home.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct Home: View {
    @State var isPressed:Bool = false
    @State private var selectionImage = 0
    @Binding var selection: Int
    
    let images = ["12","bus"]
    
    
    var body: some View {
        ZStack{
            VStack{
                ZStack(alignment: .top){
                    ReusableImage(color: "primary", height: 190)
                    HStack{
                        Rectangle()
                            .fill(.white)
                            .frame(width: 40, height: 40)
                            .overlay{
                                Image("logo").foregroundColor(.white)
                            }
                        Text("BUS CONVENIENT").bold().foregroundColor(.white).font(.system(size: 32))
                    }.offset(y:33)
                }
                
                VStack{
                
                    // search
                    ReusableSearchbar(searchKey: "")
                        .padding(.all)
                        .offset(y: -100)
                    
                    // center
                    HStack{
                        // buy ticket
                        Button(action: {
                           buyTicket()
                        }){
                            ReusableFunc(imageName: "ticket", text: "Mua vé")
                                .padding(.all)
                                .foregroundColor(.black)
                        }
                        
                        // route
                        Button(action: {
                            favorite()
                        }){
                            ReusableFunc(imageName: "favorite", text: "Yêu thích")
                                .padding(.all)
                                .foregroundColor(.black)
                        }
                        
                        // feedback
                        Button(action: {
                           feedback()
                        }){
                            ReusableFunc(imageName: "feedback", text: "Đánh giá")
                                .padding(.all)
                                .foregroundColor(.black)
                        }
                            
                        
                    }.offset(y:-100)
                    
//                    ZStack{
//                        TabView(selection: $selectionImage) {
//                            ForEach(0..<2){ index in
//                                Image("\(images[index])")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: .infinity)
//                            }
//                        }.tabViewStyle(PageTabViewStyle())
//                    }.offset(y:-105)
                    Image("Container").resizable().scaledToFit().offset(y:-50)
                    
                }
                
                Spacer()
            }
        }
    }
    
    func buyTicket(){
        
    }
    
    func favorite(){
        
    }
    
    func feedback(){
        
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(selection: .constant(1))
    }
}
