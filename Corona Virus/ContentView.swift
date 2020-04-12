//
//  ContentView.swift
//  Corona Virus
//
//  Created by Michel Garlandat on 30/03/2020.
//  Copyright © 2020 Michel Garlandat. All rights reserved.
//

import SwiftUI

struct Case: Decodable, Identifiable {
    let id = UUID()
    var cases: Double
    var deaths: Double
    var updated: Double
    var recovered: Double
    var active: Double
    
    init(
        cases: Double = 0,
        deaths: Double = 0,
        updated: Double = 0,
        recovered: Double = 0,
        active: Double = 0) {
        
        self.cases = cases
        self.deaths = deaths
        self.updated = updated
        self.recovered = recovered
        self.active = active
    }
}

struct Details: Decodable, Identifiable {
    let id = UUID()
    var country: String
    var cases: Double
    var deaths: Double
    var recovered: Double
    var critical: Double
    var casesPerOneMillion: Double?
    var deathsPerOneMillion: Double?
    var todayCases: Double?
    var todayDeaths: Double?
}

struct ContentView: View {
    @State var posts = Case()
    @State var details: [Details] = []
    @State var sortedDetails: [Details] = []
    @State var statsOn = false
    @State var alphaSort = false
    @State var txt: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                // Titre
                Text("COVID 19")
                    .fontWeight(.black)
                HStack {
                    Toggle(isOn: self.$alphaSort) {
                        Text("Tri alphabetique")
                    }
                    
                    Toggle(isOn: self.$statsOn) {
                        Text("Statistiques")
                    }
                }
                
                //            SearchView()
                
                // Cas Mondiaux
                VStack {
                    Text("Cases: \(getValue(data: self.posts.cases))")
                    Text("Actives: \(getValue(data: self.posts.active))")
                    Text("Death: \(getValue(data: self.posts.deaths))")
                    Text("Recovered: \(getValue(data: self.posts.recovered))")
                    Text("Updated: \(getDate(time: self.posts.updated))")
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
                    if !self.statsOn {
                        HStack {
                            Text("Country")
                                
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, 0)
                            
                            Text("cases")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                            
                            Text("deaths")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                            
                            Text("recovered")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                            
                            Text("critical")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                        }
                        .background(Color.green)
                        .foregroundColor(.white)
                        
                    } else {
                        HStack {
                            Text("Country")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                            
                            Text("cases/M")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                            
                            Text("death/M ")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                            
                            Text("Today cases")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                            
                            Text("Today deaths")
                                .font(.system(size: 12))
                                .fontWeight(.medium)
                                .frame(width: geo.size.width / 5)
                                .padding(.horizontal, -5)
                        }
                        .background(Color.yellow)
                        .foregroundColor(.white)
                    }
                }.padding(.leading, 0)
                
                // Listes
                if self.alphaSort {
                    List(self.sortedDetails) { detail in
                        HStack {
                            
                            if detail.country == "France" {
                                Text(detail.country)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .frame(width: geo.size.width / 5 + 12 )
                                    .background(Color(.red))
                            } else {
                                Text(detail.country)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .frame(width: geo.size.width / 5 + 12 )
                            }
                            
                            if !self.statsOn {
                                Text("\(getValue(data: detail.cases))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                                
                                Text("\(getValue(data: detail.deaths))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, -10)
                                
                                Text("\(getValue(data: detail.recovered))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                Text("\(getValue(data: detail.critical))")
                                    .font(.system(size: 12))
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                            } else {
                                Text("\(getValue(data: detail.casesPerOneMillion ?? 0 ))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                                Text("\(getValue(data: detail.deathsPerOneMillion ?? 0))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                                Text("\(getValue(data: detail.todayCases ?? 0))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                                Text("\(getValue(data: detail.todayDeaths ?? 0))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .foregroundColor(.pink)
                                    .padding(.horizontal, -10)
                            }
                        }
                    }
                        
                    .onAppear() {
                        GetData().updateData3() { (details) in
                            self.sortedDetails = details
                        }
                    }
                    .padding(.horizontal, 0)
                } else {
                    List(self.details) { detail in
                        HStack {
                            
                            if detail.country == "France" {
                                Text(detail.country)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .frame(width: geo.size.width / 5 + 12 )
                                    .background(Color(.red))
                            } else {
                                Text(detail.country)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .frame(width: geo.size.width / 5 + 12 )
                            }
                            
                            if !self.statsOn {
                                Text("\(getValue(data: detail.cases))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                                
                                Text("\(getValue(data: detail.deaths))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, -10)
                                
                                Text("\(getValue(data: detail.recovered))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                Text("\(getValue(data: detail.critical))")
                                    .font(.system(size: 12))
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                            } else {
                                Text("\(getValue(data: detail.casesPerOneMillion ?? 0 ))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                                Text("\(getValue(data: detail.deathsPerOneMillion ?? 0))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                                Text("\(getValue(data: detail.todayCases ?? 0))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .padding(.horizontal, -10)
                                Text("\(getValue(data: detail.todayDeaths ?? 0))")
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                    .frame(width: geo.size.width / 5)
                                    .foregroundColor(.pink)
                                    .padding(.horizontal, -10)
                            }
                        }
                    }
                        
                    .onAppear() {
                        GetData().updateData2() { (details) in
                            self.details = details
                        }
                        
                    }
                    .padding(.horizontal, 0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone X")
    }
}

class GetData {
    
    // Global
    func updateData(completion: @escaping (Case) -> ()) {
        let url = "https://corona.lmao.ninja/all"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            guard let data = data else {
                //                print("No Data")
                return }
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let posts = try! JSONDecoder().decode(Case.self, from: data)
            //            print(posts)
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
