//
//  NakaiyDetail.swift
//  Nakaiy Nevi
//
//  Created by Simon Shareef on 12/05/2023.
//

import SwiftUI

struct NakaiyDetail: View {
    @Environment(\.dismiss) var dismiss
    @State private var nakaiy: Nakaiy
    
    init(nakaiy: Nakaiy) {
        _nakaiy = State(initialValue: nakaiy)
    }
    var body: some View {
        
        VStack {
            VStack(alignment: .trailing) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("arrowBackSmBlk")
                            .padding(10)
                    }
                    Spacer()
                    Button {
                        let index = (nakaiy.id == 1) ? 27 : (nakaiy.id - 1)
                        let newNakaiy = nakaiythah![index - 1]
            
                        
                        nakaiy = newNakaiy
                    } label: {
                        Image("arrowUpBlk")
                    }
                    
                    Button {
                        let index = (nakaiy.id == 27) ? 0 : nakaiy.id
                        let newNakaiy = nakaiythah![index]
                        nakaiy = newNakaiy
                    } label: {
                        Image("arrowDownBlk")
                            .padding(15)
                        
                        
                    }
                }
            }
            HStack {
                Spacer()
                VStack {
                    NakaiyWheel(nakaiy: nakaiy, listMode: false, lineWidth: 1.5)
                        .frame(width: 160, height:160)
                }
                .frame(height: 190)
                Spacer()
            }
            .background((nakaiy.season == "Iruvaa") ? Color("greenBk"): Color("blueBk"))
            
            ScrollView {



                
                VStack(alignment: .leading) {
                    Group {
                      
                        Text(nakaiy.nakaiy)
                            .font(.title2)
                        Text(nakaiy.dates.uppercased())
                            .font(.subheadline)
                        Text("")
                    }
                    Group {
                        Text(nakaiy.number)
                            .font(.custom("Gelasio-Italic", size: 17))
                        Text(nakaiy.description)
                            .font(.custom("Gelasio-Italic", size: 17))
                        Text("")
                    }
                    Group {
                        Text(NSLocalizedString("Weather",comment:"Localizable"))
                            .bold()
                        Text(nakaiy.weather)
                            .font(.custom("Gelasio-Regular", size: 16))
                        Text("")
                    }
                    Group {
                        Text(NSLocalizedString("Averages",comment:"Localizable"))
                            .bold()
                        Text(nakaiy.averages)
                            .font(.custom("Gelasio-Regular", size: 16))
                        Text("")
                        Text(NSLocalizedString("Fishing",comment:"Localizable"))
                            .bold()
                        Text(nakaiy.averages)
                            .font(.custom("Gelasio-Regular", size: 16))
                        Text("")
                    }
                    Group {
                        Text(NSLocalizedString("Meaning",comment:"Localizable"))
                            .bold()
                        Text(nakaiy.meaning)
                            .font(.custom("Gelasio-Regular", size: 16))
                        
                        Text("")
                        Text(NSLocalizedString("Asterism",comment:"Localizable"))
                            .bold()
                        Text(nakaiy.asterism)
                            .font(.custom("Gelasio-Regular", size: 16))
                            .multilineTextAlignment(.leading)
                    }
                    //Spacer()
                    
                    
                }
                .padding()
                
                Spacer()
                
                
            }
        }
    }
}

struct NakaiyDetail_Previews: PreviewProvider {
    static var previews: some View {
        NakaiyDetail(nakaiy: nakaiythah![4])
        
    }
}
