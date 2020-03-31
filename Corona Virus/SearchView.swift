//
//  SearchView.swift
//  Corona Virus
//
//  Created by Michel Garlandat on 31/03/2020.
//  Copyright © 2020 Michel Garlandat. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var show = false
        @State var txt = ""
        @State var data = ["p1","p2","p3","p4","p5","p6"]
        
        var body: some View {
            VStack(spacing: 0) {
                HStack {
                    if !self.show{
                        Text("COVID 19")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Spacer(minLength: 0)
                    
                    HStack{
                        if self.show{
                            Image(systemName: "magnifyingglass").padding(.horizontal, 8)
                            TextField("Search", text: self.$txt)
                            
                            Button(action: {
                                withAnimation {
                                    self.txt = ""
                                    self.show.toggle()
                                }
                            }) {
                                Image(systemName: "xmark").foregroundColor(.black)
                            }
                            .padding(.horizontal, 8)
                        }
                        else{
                            Button(action: {
                                withAnimation {
                                    self.show.toggle()
                                }
                            }) {
                                Image(systemName: "magnifyingglass").foregroundColor(.black).padding(10)
                            }
                        }
                    }
                    .padding(self.show ? 10 : 0)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
                .padding(.horizontal)
//                .padding(.bottom, 10)
                .background(Color.orange)
                
    //            ScrollView(.vertical, showsIndicators: false) {
//                    VStack(spacing: 15) {
//                        if self.txt != "" {
//                            if data.filter({$0.lowercased().contains(self.txt.lowercased())}).count == 0 {
//                                
//                                Text("No Results Found").padding(.top, 10)
//                            }
//                            else{
//                                
//                                ForEach(data.filter({$0.lowercased().contains(self.txt.lowercased())}),id: \.self) { data in
//                                    
//                                    Text(data )
//                                }
//                            }
//                        } else {
//                            List(data, id: \.self) { data in
//                                Text(data)
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 15)
//                    .padding(.top, 10)
    //            }
            }
            .edgesIgnoringSafeArea(.top)
        }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
