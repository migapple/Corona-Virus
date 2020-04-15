//
//  BandeauView.swift
//  Corona Virus
//
//  Created by Michel Garlandat on 15/04/2020.
//  Copyright © 2020 Michel Garlandat. All rights reserved.
//

import SwiftUI

struct BandeauView: View {
    @Binding var statsOn: Bool
    
    var body: some View {
        GeometryReader { geo in
            if !self.statsOn {
                HStack {
                    Text("country")
                        
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
                        .frame(width: geo.size.width / 4)
                        .padding(.horizontal, -5)
                }
                .background(Color.green)
                .foregroundColor(.white)
                
            } else {
                HStack {
                    Text("country")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(width: geo.size.width / 5)
                        .padding(.horizontal, -5)
                    
                    Text("cases/M")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(width: geo.size.width / 5)
                        .padding(.horizontal, -5)
                    
                    Text("death/M")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(width: geo.size.width / 5)
                        .padding(.horizontal, -5)
                    
                    Text("today cases")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(width: geo.size.width / 5)
                        .padding(.horizontal, -5)
                    
                    Text("today deaths")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .frame(width: geo.size.width / 4)
                        .padding(.horizontal, -5)
                }
                .background(Color.yellow)
                .foregroundColor(.white)
            }
        }
    }
}


struct BandeauView_Previews: PreviewProvider {
    @Binding var statsOn: Bool
    static var previews: some View {
        BandeauView(statsOn: .constant(true))
    }
}
