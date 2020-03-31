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
//    @ObservedObject var data = getData()
    @State var posts = Case()
    @State var details: [Details] = []
    @State var statsOn = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Covid 19")
                    .font(.largeTitle)
                    .padding()
                
                Toggle(isOn: $statsOn) {
                    Text("Statistiques")
                }
            }
            VStack {
                Text("Cases: \(getValue(data: posts.cases))")
                Text("Actives: \(getValue(data: posts.active))")
                Text("Death: \(getValue(data: posts.deaths))")
                Text("Recovered: \(getValue(data: posts.recovered))")
                Text("Updated: \(getDate(time: posts.updated))")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .background(Color.red)
        .padding()
                
            .onAppear() {
                GetData().updateData { (posts) in
                    self.posts = posts
                }
            }
            
            HStack {
                if !self.statsOn {
                    HStack {
                        Text("Country")
                        .frame(width: 124)
                            .font(.system(size: 12))

                        Text("cases")
                        .frame(width: 60)
                        .font(.system(size: 12))


                        Text("deaths")
                        .frame(width: 60)
                        .font(.system(size: 12))


                        Text("recovered")
                        .frame(width: 60)
                        .font(.system(size: 12))


                        Text("critical")
                        .frame(width: 60)
                        .font(.system(size: 12))


                    }
                    .background(Color.green)
                    .foregroundColor(.white)
                    
                } else {
                    HStack {
                        Text("Country")
                        .frame(width: 124)
                        .font(.system(size: 12))


                        Text("cases/M")
                        .frame(width: 60)
                        .font(.system(size: 12))


                        Text("death/M ")
                        .frame(width: 60)
                        .font(.system(size: 12))


                        Text("Today cases")
                        .frame(width: 60)
                        .font(.system(size: 12))

                        
                        Text("Today deaths")
                        .frame(width: 60)
                        .font(.system(size: 12))

                    }
                    .background(Color.yellow)
                    .foregroundColor(.white)
                }
            }.padding(.leading, -20)
                
            List(details) { detail in
                HStack {
                    Text(detail.country)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                    .frame(width: 100)
                    if !self.statsOn {
                        Text("\(getValue(data: detail.cases))")
                            .font(.system(size: 12))

                            .frame(width: 60)
                        
                        Text("\(getValue(data: detail.deaths))")
                            .font(.system(size: 12))

                            .frame(width: 60)
                            .foregroundColor(.red)
                        Text("\(getValue(data: detail.recovered))")
                            .font(.system(size: 12))

                            .frame(width: 60)
                        Text("\(getValue(data: detail.critical))")
                            .font(.system(size: 12))

                            .frame(width: 60)
                    } else {
                        Text("\(getValue(data: detail.casesPerOneMillion ?? 0 ))")
                            .font(.system(size: 12))

                            .frame(width: 60)
                        Text("\(getValue(data: detail.deathsPerOneMillion ?? 0))")
                            .font(.system(size: 12))

                            .frame(width: 60)
                        Text("\(getValue(data: detail.todayCases ?? 0))")
                            .font(.system(size: 12))

                            .frame(width: 60)
                            Text("\(getValue(data: detail.todayDeaths ?? 0))")
                                .font(.system(size: 12))

                            .frame(width: 60)
                            .foregroundColor(.pink)
                    }
                }
            }
            .onAppear() {
                GetData().updateData2 { (details) in
                    self.details = details
                }
            }
            .padding(.horizontal, -18)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//class getData: ObservableObject {
//    @Published var casMondiaux: Case!
//    @Published var countries = [Details]()
//
//    init() {
//        updateData()
//    }
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
        
//        for i in country {
//            session1.dataTask(with: URL(string: url1+i)!) { (data, _, err) in
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                    return
//                }
//
//                let json = try! JSONDecoder().decode(Details.self, from: data!)
//
//                DispatchQueue.main.async {
//                    self.countries.append(json)
//                }
//            }.resume()
//        }
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
//            print(details)
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
