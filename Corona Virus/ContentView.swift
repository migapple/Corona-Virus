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
    @State var showSearchBar = false
    @State var searchText: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
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
                            TextField("Search Country", text: self.$searchText)
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
                            List(self.details.filter({$0.country.contains(self.searchText.lowercased())})) { detail in
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

class GetData {
    // Global
    func updateData(completion: @escaping (Case) -> ()) {
        let url = "https://corona.lmao.ninja/all"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            guard let data = data else {
                return }
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let posts = try! JSONDecoder().decode(Case.self, from: data)
            DispatchQueue.main.async {
                completion(posts)
            }
        }.resume()
    }
    
    // Detail
    func updateData2(completion: @escaping ([Details]) -> ()) {
        let url = "https://corona.lmao.ninja/countries"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            guard let data = data else {
                print("No Data")
                return }
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let details = try! JSONDecoder().decode([Details].self, from: data)
            
            let sortedDetails = details.sorted {
                $0.cases > $1.cases
            }
            
            DispatchQueue.main.async {
                completion(sortedDetails)
            }
            
        }.resume()
    }
    
    func updateData3(completion: @escaping ([Details]) -> ()) {
        let url = "https://corona.lmao.ninja/countries"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            guard let data = data else {
                print("No Data")
                return }
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let details = try! JSONDecoder().decode([Details].self, from: data)
            
            DispatchQueue.main.async {
                completion(details)
            }
        }.resume()
    }
}

// MARK: - Permet de changer la barre de demarrage
class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

func getDate(time: Double) -> String {
    let date = Double(time / 1000)
    let format = DateFormatter()
    format.dateFormat = "MMM - dd - YYYY hh:mm a"
    return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
}

func getValue(data: Double) -> String {
    let format = NumberFormatter()
    format.numberStyle = .decimal
    return format.string(for: data)!
}
