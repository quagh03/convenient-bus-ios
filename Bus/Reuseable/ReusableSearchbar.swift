//
//  ReusableSearchbar.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct ReusableSearchbar: View {
    @State var searchKey: String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            TextField("Tìm kiếm tuyến đường", text: $searchKey)
        }
        .font(.headline)
        .padding(.all)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .black, radius: 3, x: 0, y: 0)
        )
    }
}

struct ReusableSearchbar_Previews: PreviewProvider {
    static var previews: some View {
        ReusableSearchbar(searchKey: "")
    }
}
