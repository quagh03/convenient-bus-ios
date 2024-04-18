//
//  test2.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 16/04/2024.
//

import SwiftUI
import Combine

struct test2: View {
    @State var isPress : Bool = false
    var body: some View {
        NavigationView{
            VStack{
                Button {
                    isPress.toggle()
                } label: {
                    Text("Press 1")
                }

                if isPress {
                    NavigationLink(destination: test3(), isActive: $isPress) {
                        EmptyView()
                    }
                }
            }
        }
        
    }
}

struct Screen1: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Screen2()) {
                    Text("Go to Screen 2")
                }
            }
        }
    }
}

struct Screen2: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            NavigationLink(destination: Screen3()) {
                Text("Go to Screen 3")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.blue)
        })
    }
}

struct Screen3: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Button("Dismiss to Screen 1") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}




struct test2_Previews: PreviewProvider {
    static var previews: some View {
        Screen1()
    }
}
