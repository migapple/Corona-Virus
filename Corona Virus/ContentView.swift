//
//  ContentView.swift
//  Corona Virus
//
//  Created by Michel Garlandat on 30/03/2020.
//  Copyright © 2020 Michel Garlandat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @State var posts = Case()
    @State var details: [Details] = []
    @State var sortedDetails: [Details] = []
    @State var statsOn = false
    @State var alphaSort = false
   
    @State var searchText: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                SearchBarView(searchText: self.$searchText)
                
                // Toggle
                HStack {
                    Toggle(isOn: self.$alphaSort) {
                        Text("alphanumeric")
                    }
                    
                    Toggle(isOn: self.$statsOn) {
                        Text("statistics")
                    }
                }
                .padding(.bottom, 10)
                .padding(.top, 10)
                
                // Cas Mondiaux
                VStack {
                    Text("cases: \(getValue(data: self.posts.cases))")
                    Text("actives: \(getValue(data: self.posts.active))")
                    Text("deaths: \(getValue(data: self.posts.deaths))")
                    Text("recovered: \(getValue(data: self.posts.recovered))")
                    Text("updated: \(getDate(time: self.posts.updated))")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                .background(Color.red)
                .padding()
                    
                    // Récupération des données
                    .onAppear() {
                        GetData().updateData { (posts) in
                            self.posts = posts
                        }
                }
                
                // Titres
                HStack {
                    BandeauView(statsOn: self.$statsOn)
                }
                .frame(height:20)
                .padding(.bottom, 0)
                
                // Listes
                VStack {
                    if self.alphaSort {
                        List(self.sortedDetails) { detail in
                            ListView(statsOn: self.$statsOn, detail: detail)
                        }
                        .onAppear() {
                            GetData().updateData3() { (details) in
                                self.sortedDetails = details
                            }
                        }
                        .padding(.horizontal, 0)
                    } else {
                        if self.searchText != "" {
                            Text(self.searchText)
                            List(self.details.filter({$0.country.contains(self.searchText)})) { detail in
                                ListView(statsOn: self.$statsOn, detail: detail)
                            }
                        } else {
                            List(self.details) { detail in
                                ListView(statsOn: self.$statsOn, detail: detail)
                            }
                        }
                    }
                }
                .onAppear() {
                    GetData().updateData2() { (details) in
                        self.details = details
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "fr"], id: \.self) { localeIdentifier in
            ContentView()
                .environment(\.locale, .init(identifier: localeIdentifier))
                .previewDisplayName(localeIdentifier)
        }
    }
}

// MARK: - Permet de changer la barre de demarrage
class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// MARK: - Extension for fermer le clavier
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
