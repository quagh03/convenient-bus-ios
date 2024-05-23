//
//  EmailAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 03/05/2024.
//

import Foundation

class EmailAPI: ObservableObject{
    
    func sendEmail(){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/mail/sendVerificationEmail") else {
            print("invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
    }
}
