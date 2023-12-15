//
//  IntroView.swift
//  Nakaiy Nevi
//
//  Created by Simon Shareef on 16/05/2023.
//

import SwiftUI

struct IntroView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .trailing) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("arrowBackSmBlk")
                            .padding(10)
                    }
                    Spacer()
                }
            }
            //BODY
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Nakaiy")
                                .font(.title)
                                
                                
                            Text("\(NSLocalizedString("an indigenous system",comment:"Localizable"))")
                                .font(.custom("Gelasio-Italic", size: 17))
                                
                            Image("explainer")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(10)
                                .frame(height: 230)
                                
                            //WheelBackground(nakaiy: nakaiythah[5], listMode: false,lineWidth: 2.0)
                            
                            
                            
                            Text("\(NSLocalizedString("IntroText",comment:"Localizable"))")
                                .font(.custom("Gelasio-Regular", size: 15))
                                
                            Text("\(NSLocalizedString("Quote",comment:"Localizable"))")
                                .font(.custom("Gelasio-Italic", size: 15))
                                
                            Divider()
                            Text("\(NSLocalizedString("Sources",comment:"Localizable"))")
                                .font(.custom("Gelasio-Italic", size: 13))
                               
                            Divider()
                            Group {
                                Text("\(NSLocalizedString("Designed and Developed by",comment:"Localizable"))")
                                    .font(.custom("Gelasio-Regular", size: 13))
                                   
                                
                                Link("Shahee Ilyas", destination: URL(string: "https://shaheeilyas.com/")!)
                                    .font(.custom("Gelasio-Regular", size: 13))
                                    .padding(.leading, 50)
                                    .foregroundColor(Color.gray)
                                
                                Link("Ayeshath Fadwa", destination: URL(string: "https://monochromist.com/")!)
                                    .font(.custom("Gelasio-Regular", size: 13))
                                    .padding(.bottom, 4)
                                    .padding(.leading, 50)
                                    .foregroundColor(Color.gray)
                                
                                Text("\(NSLocalizedString("Special Thanks",comment:"Localizable"))")
                                    .font(.custom("Gelasio-Regular", size: 13))
                                    
                                
                                Link("Ali Shafee Saeed (Topi)", destination: URL(string: "http://www.topysaeed.com/")!)
                                    .font(.custom("Gelasio-Regular", size: 13))
                                    .padding(.bottom, 4)
                                    .padding(.leading, 50)
                                    .foregroundColor(Color.gray)
                                
                                Text("\(NSLocalizedString("Ported by",comment:"Localizable"))")
                                    .font(.custom("Gelasio-Regular", size: 13))
                                 
                                
                                Link("Simon Shareef", destination: URL(string: "http://www.sshareef.com")!)
                                    .font(.custom("Gelasio-Regular", size: 13))
                                    .padding(.leading, 50)
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(10)
                    
                }
                .background(Color("introBg"))
                Spacer()
            }
            Spacer()
        
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
