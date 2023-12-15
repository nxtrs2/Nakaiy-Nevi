//
//  NakaiyRow.swift
//  Nakaiy Nevi
//
//  This View defines a single item in the NakaiList
//  A Nakaiy type is passed from which the nakaiy name and dates are taken
//  Created by Simon Shareef on 11/05/2023.
//

import SwiftUI

struct NakaiyRow: View {
    var nakaiy: Nakaiy

    var body: some View {
        let bgColor = (nakaiy.season == "Iruvaa") ? "greenBkList" : "blueBkList"
        HStack {
            Rectangle()
                .fill(Color.red)
                .opacity(0)
                .frame(width:0,height:40)
            NakaiyWheel(nakaiy: nakaiy, listMode: true, lineWidth: 1.0)
                .frame(width: 60, height:65)

            VStack(alignment: .leading) {

                Text(nakaiy.nakaiy)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text(nakaiy.dates.uppercased())
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                
            }
            Spacer()

            Image("arrowRight")
                .frame(width: 40)

            
        }
        .padding(0)
        .background(Color(bgColor))
        .ignoresSafeArea()

    }
}

struct NakaiyRow_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            NakaiyRow(nakaiy: nakaiythah![0])
            NakaiyRow(nakaiy: nakaiythah![1])
                
        }
        .previewLayout(.fixed(width:300,height:70))
    }
}
