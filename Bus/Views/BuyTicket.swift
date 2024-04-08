//
//  BuyTicket.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 05/04/2024.
//

import SwiftUI

struct BuyTicket: View {
    @State var items = [
        ["Vé liên tuyến" , "200000", "1"]
    ]
    
    
    var body: some View {
        ZStack{
            VStack{
                ZStack(alignment:.top){
                    Rectangle()
                        .frame(height: 158)
                        .foregroundColor(Color("primary"))
                        .clipShape(RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 20))
                    BarBackCustom(color: .white ,nameRoute: "Đăng ký vé tháng").padding(.horizontal).padding(.top)
                    
                    // vstack
                    VStack{
                        VStack{
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.white)
                                .padding(.horizontal)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(.gray, lineWidth: 1)
                                        .frame(maxWidth: 365)
                                }
                                .overlay{
                                    VStack{
                                        HStack(alignment: .center){
                                            ReusableFunc(imageName: "ticket", text: "")
                                                .padding(.all)
                                                .foregroundColor(.black)
                                            //
                                            VStack(alignment: .leading, spacing: 5){
                                                Text("Vé tháng liên tuyến").bold().font(.system(size: 20))
                                                Text("Thời hạn: 1 tháng").font(.system(size: 15)).foregroundColor(.black)
                                            }
                                            Spacer()
                                            
                                        }.padding(.horizontal)
                                        // end HStack
                                        
                                        // line
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 365, height: 1)
                                        
                                        // table
                                        Rectangle()
                                            .fill(.clear)
                                            .frame(width: 365, height: 52)
                                            .overlay{
                                                //table
                                                LazyVGrid(columns: [
                                                    GridItem(.flexible(), spacing: 16),
                                                    GridItem(.flexible(), spacing: 16),
                                                    GridItem(.flexible(), spacing: 16),
                                                ], spacing: 16) {
                                                    // Tiêu đề của các cột
                                                    
                                                    Text("Loại").fontWeight(.bold)
                                                    Text("Giá").fontWeight(.bold)
                                                    Text("Số lượng").fontWeight(.bold)
                                                    
                                                    
                                                    // Các hàng dữ liệu
                                                    ForEach(items.indices, id: \.self) { index in
                                                        Text(items[index][0]) // Loại
                                                        Text(items[index][1]) // Giá
                                                        Text(items[index][2]) // Số lượng
                                                    }
                                                }
                                                .padding(.horizontal)
                                                
                                            }
                                        // end table
                                        Spacer()
                                        HStack(alignment: .top){
                                            Text("*Thời hạn của vé bắt đầu từ ngày đăng ký").foregroundColor(.red)
                                        }
                                        
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 365, height: 1)
                                        
                                        // pay
                                        HStack{
                                            Text("Tổng cộng").bold()
                                            Spacer()
                                            Text("100000").bold()
                                        }.padding(.horizontal)
                                            .padding(.bottom,10)
                                            .frame(maxWidth: 365)
                                        
                                        ReuseableButton(red: 96/255, green: 178/255, blue: 240/255, text: "Tiếp tục", width: .infinity, imgName: "", textColor: .white) {
                                            
                                        }.padding(.bottom,15)
                                            .padding(.horizontal)
                                        
                                    }
                                    .frame(maxWidth: 365 ,maxHeight: .infinity)
                                }
                            // end overlay
                            
                        }
                    }
                    .padding(.top,100)
                    // end form
                    
                    Spacer()
                }
                // end ZStack
            }
        }
    }
}

struct BuyTicket_Previews: PreviewProvider {
    static var previews: some View {
        BuyTicket()
    }
}
