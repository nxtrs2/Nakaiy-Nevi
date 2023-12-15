//
//  MediumView.swift
//  Nakaiy WidgetExtension
//
//  Created by Simon Shareef on 13/06/2023.
//

import WidgetKit
import SwiftUI


struct MediumView: View {
    var entry: NakaiyEntry
   
    //@State private var currentNakaiyInfo = getCurrentNakaiyInfo()
    
    var body: some View {
        let nakaiyInfo = getCurrentNakaiyInfo(day: entry.date)
        let nakaiy = nakaiythah![nakaiyInfo.nId - 1]
        let nakaiyWheel = NakaiyWheel(nakaiy: nakaiy, listMode: false, lineWidth: 1.5)
        ZStack {
            ContainerRelativeShape()
                .fill((nakaiy.season == "Iruvaa") ? Color("greenBk"): Color("blueBk"))
            HStack {
               
                nakaiyWheel
                    .frame(width:140, height: 140)
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Rectangle()
                            .opacity(0)
                            .frame(width: 35)
                        VStack(alignment: .leading) {
                            Text("\(nakaiyInfo.nDay) \(nakaiy.nakaiy)")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            Text(nakaiy.dates.uppercased())
                                .font(.footnote)
                                .foregroundColor(.white)
                            Divider()
                                .opacity(0)
                            Text(nakaiy.number)
                                .foregroundColor(.white)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                            
                            Text(nakaiy.description)
                                .foregroundColor(.white)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .italic()
                        }
                    }

                    Spacer()
                }

            }
            .padding()
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color("orangeBk"))
                    .frame(width:20,height:50)
                    .offset(x: geometry.size.width / 2 + -10, y: geometry.size.height / 2 + -85)
            }

        }
        
    }
}


//struct MediumView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediumView()
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}
