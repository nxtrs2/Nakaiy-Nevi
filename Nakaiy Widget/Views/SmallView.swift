//
//  SmallView.swift
//  Nakaiy WidgetExtension
//
//  Created by Simon Shareef on 13/06/2023.
//
import WidgetKit
import SwiftUI

struct SmallView: View {
    var entry: NakaiyEntry

    //@State private var currentNakaiyInfo = getCurrentNakaiyInfo()
    
    var body: some View {
        let nakaiyInfo = getCurrentNakaiyInfo(day: entry.date)
        let nakaiy = nakaiythah![nakaiyInfo.nId - 1]
        let nakaiyWheel = NakaiyWheel(nakaiy: nakaiy, listMode: false, lineWidth: 1.5)
        ZStack {
            ContainerRelativeShape()
                .fill((nakaiy.season == "Iruvaa") ? Color("greenBk"): Color("blueBk"))
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color("orangeBk"))
                    .frame(width:17,height:30)
                    .offset(x: -geometry.size.width / 2 + 80, y: geometry.size.height / 2 + 44)
            }
            VStack  {
                nakaiyWheel //draw the wheel
                    .frame(width:110, height: 110)
                Text("\(nakaiyInfo.nDay) \(nakaiy.nakaiy)")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                Text(nakaiy.dates.uppercased())
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.white)

            }

            
        }
        
    }
}

//struct SmallView_Previews: PreviewProvider {
//    static var previews: some View {
//        SmallView()
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
