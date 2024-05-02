//
//  testDropdown.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/04/2024.
//

import SwiftUI

struct testDropdown: View {
    @State var show = false
    @State var name: String = "Tuyến xe"
    @State var busRoute: [BusRoute]?
    @ObservedObject var busRouteAPI = BusRoutesApi()
    var body: some View {
        VStack{
            VStack() {
                ZStack{
                    RoundedRectangle(cornerRadius: 10).frame(height: 60)
                        .foregroundColor(.white)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray,lineWidth: 1)
                        }
                    HStack{
                        Text(name)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .rotationEffect(.degrees(show ? 90 : 0))
                    }.padding(.horizontal)
                }
//                .offset(y: -145)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                    }
                }

                // menu
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
//                        .fill(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray,lineWidth: 1)
                        }
                    ScrollView {
                            VStack(spacing: 17){
                                ForEach(1..<5, id: \.self) { item in
                                    Button {
//                                        name = item.routeName
                                        name = String(item)
                                    } label: {
                                        Text("s")
                                            .foregroundColor(.black).bold()
                                        
                                    }
                                }
                                .padding(.horizontal)
                                .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity,alignment:.leading)
                            .padding(.vertical,15)
                        
                        
                    }
                }
                .foregroundColor(Color("lightGray").opacity(1))
                .frame(height: show ? 100 : -60)
                    .offset(y: show ? 10 : 0)
                
                // text hien thi
                                //end
            }
        }
        .padding()
    }
}

struct testDropdown_Previews: PreviewProvider {
    static var previews: some View {
        testDropdown()
    }
}
