//
//  ListVew.swift
//  Corona Virus
//
//  Created by Michel Garlandat on 15/04/2020.
//  Copyright © 2020 Michel Garlandat. All rights reserved.
//

import SwiftUI

struct ListView: View {
    @Binding var statsOn: Bool
    var detail : Details
    
    var body: some View {
        GeometryReader { geo in
        HStack {
            if !self.statsOn {
                Text(self.detail.country)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 4)
                    .padding(.horizontal, 0)
                Text("\(getValue(data: self.detail.cases))")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 5)
                    .padding(.horizontal, -10)
                
                Text("\(getValue(data: self.detail.deaths))")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 5)
                    .foregroundColor(.red)
                    .padding(.horizontal, -10)
                
                Text("\(getValue(data: self.detail.recovered))")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 5)
                Text("\(getValue(data: self.detail.critical))")
                    .font(.system(size: 12))
                    .frame(width: geo.size.width / 5)
                    .padding(.horizontal, -10)
            } else {
                Text(self.detail.country)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 4)
                    .padding(.horizontal, 0)
                Text("\(getValue(data: self.detail.casesPerOneMillion ?? 0 ))")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 5)
                    .padding(.horizontal, -10)
                Text("\(getValue(data: self.detail.deathsPerOneMillion ?? 0))")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 5)
                    .padding(.horizontal, -10)
                Text("\(getValue(data: self.detail.todayCases ?? 0))")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 5)
                    .padding(.horizontal, -10)
                Text("\(getValue(data: self.detail.todayDeaths ?? 0))")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .frame(width: geo.size.width / 5)
                    .foregroundColor(.pink)
                    .padding(.horizontal, -10)
            }
        }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(statsOn: .constant(false), detail: Details(country: "France", cases: 1, deaths: 2, recovered: 3, critical: 4, casesPerOneMillion: 5, deathsPerOneMillion: 6, todayCases: 7, todayDeaths: 8))
    }
}
