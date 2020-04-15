//
//  SearchBarView.swift
//  Corona Virus
//
//  Created by Michel Garlandat on 15/04/2020.
//  Copyright © 2020 Michel Garlandat. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @State var showSearchBar = false
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            if !self.showSearchBar {
                Text("COVID 19")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
            }
            
            Spacer(minLength: 0)
            
            // Bar de recherche
            HStack {
                if self.showSearchBar {
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal, 8)
                    TextField("searchCountry", text: self.$searchText)
                    Button(action: {
                        UIApplication.shared.endEditing()
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    
                    Button(action: {
                        withAnimation {
                            self.searchText = ""
                            self.showSearchBar.toggle()
                        }
                    }) {
                        Image(systemName: "xmark").foregroundColor(.black)
                    }
                    .padding(.horizontal, 8)
                }
                else{
                    Button(action: {
                        withAnimation {
                            self.showSearchBar.toggle()
                        }
                    }) {
                        Image(systemName: "magnifyingglass").foregroundColor(.black).padding(10)
                    }
                }
            }
            .padding(self.showSearchBar ? 10 : 0)
            .background(Color.white)
            .cornerRadius(20)
        }
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 0)
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.orange)
    }
}

struct SearchBarView_Previews: PreviewProvider {

    
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
