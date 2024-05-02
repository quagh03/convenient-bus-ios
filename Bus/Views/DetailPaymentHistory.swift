//
//  DetailPaymentHistory.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 18/04/2024.
//

import SwiftUI

struct DetailPaymentHistory: View {
    @State var imgName: String
    @State var status: String
    @State var txtColor: Color
    @State var vnpId: String
    @State var time: String
    @State var desc: String
    @State var userName: String
    @State var email:String
    @State var phone: String
    @State var amount: Double
    
    var body: some View {
        ZStack{
            VStack{
                // retangle
                ZStack(alignment:.top){
                    Rectangle()
                        .frame(height: 158)
                        .foregroundColor(Color("primary"))
                        .clipShape(RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 20))
                    BarBackCustom(back: "",color: .white ,nameRoute: "Chi tiết giao dịch").padding(.horizontal).padding(.top)
                    
                    
                    // Form nạp tiền
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
                                        VStack{
                                            // top
                                            VStack{
                                                ZStack{
                                                    Circle()
                                                        .stroke(.gray,lineWidth: 1)
                                                        .frame(width: 85)
                                                    Image(imgName).resizable().scaledToFit()
                                                        .frame(width: 60, height: 60)
                                                }
                                                HeightSpacer(heightSpacer: 3)
                                                //
                                                Text(formatter(amount)).font(.system(size: 20))
                                            }
                                            .padding(.vertical)
                                            .padding(.top, 25)
                                            
                                            // mid
                                            VStack{
                                                HStack{
                                                    Text("Trạng thái")
                                                    Spacer()
                                                    Text(status)
                                                        .foregroundColor(txtColor)
                                                }.padding(.all)
                                                    .overlay{
                                                        RoundedRectangle(cornerRadius: 1)
                                                            .stroke(lineWidth: 1)
                                                            .foregroundColor(Color("lightGray"))
                                                    }
                                            }
                                            
                                            HeightSpacer(heightSpacer: 14)
                                            
                                            VStack(spacing: 15){
                                                HStack{
                                                    Text("Mã giao dịch")
                                                    Spacer()
                                                    Text(vnpId)
                                                }
                                                HStack{
                                                    Text("Thời gian")
                                                    Spacer()
                                                    Text(time)
                                                }
                                                HStack{
                                                    Text("Mô tả")
                                                    Spacer()
                                                    Text(desc)
                                                }
                                            }.padding(.all)
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 1)
                                                        .stroke(lineWidth: 1)
                                                        .foregroundColor(Color("lightGray"))
                                                }
                                                
                                            HeightSpacer(heightSpacer: 14)
                                            VStack(spacing: 15){
                                                HStack{
                                                    Text("Họ và tên")
                                                    Spacer()
                                                    Text(userName)
                                                }
                                                HStack{
                                                    Text("Email")
                                                    Spacer()
                                                    Text(email)
                                                }
                                                HStack{
                                                    Text("Phone")
                                                    Spacer()
                                                    Text(phone)
                                                }
                                            }.padding(.all)
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 1)
                                                        .stroke(lineWidth: 1)
                                                        .foregroundColor(Color("lightGray"))
                                                }
                                            
                                            
                                            
                                           
                                            
                                            Spacer()
                                            
                                            
                                            
                                        }
//                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        
                                    }.frame(maxWidth: 365 ,maxHeight: .infinity)
                                    // end Vstack 1 overlay
                                    
                                }
                        }
                    }.padding(.top, 70)
                    // end form
                }
                Spacer()
            }
            // end VStack
        }
    }
    
    func formatter(_ number:Double) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        guard let formattedString = formatter.string(from: NSNumber(value: number)) else {
                return "Error formatting number."
            }
        return formattedString
    }
}

struct DetailPaymentHistory_Previews: PreviewProvider {
    static var previews: some View {
        DetailPaymentHistory(imgName: "addCard", status: "Thành công",txtColor: .green, vnpId: "Trans",time: "4/2042",desc: "Nap tien",userName: "Hieu", email: "hh@gmail.com", phone: "097788723", amount: 200000)
    }
}
