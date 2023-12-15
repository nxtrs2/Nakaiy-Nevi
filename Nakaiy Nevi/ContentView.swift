//
//  ContentView.swift
//  Nakaiy Nevi
//
//  Created by Simon Shareef on 10/05/2023.
//

import SwiftUI
import UIKit

// This is used by the Sharesheet.
struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {
    }
}

struct ContentView: View {
    @State private var dateString = getFormattedDate()
    @State private var currentNakaiyInfo = getCurrentNakaiyInfo(day: Date.now)
    @State private var showingDetailsSheet = false
    @State private var showingListSheet = false
    @State private var isAnimating = false
    @State private var showShareSheet = false
    
    var body: some View {

        //let dateString = getFormattedDate()
        //let currentNakaiyInfo = getCurrentNakaiyInfo()
        
        let nakaiy = nakaiythah![currentNakaiyInfo.nId - 1]
        let nakaiyWheel = NakaiyWheel(nakaiy: nakaiy, listMode: false, lineWidth: 1.5)
        VStack(alignment: .leading) {
            
            //grap

            //HEAD
            HStack {
                Button {
                    showingListSheet.toggle()
                } label: {
                    VStack(alignment: .leading) {
                        Text("NAKAIY NEVI")
                            .font(.title)
                            .foregroundColor(Color("blackTxt"))
                        Text("\(NSLocalizedString("Seasons of Maldives",comment:"Localizable"))")
                            .font(.custom("Gelasio-Italic", size: 17))
                            .foregroundColor(Color("blackTxt"))
                        
                    }
                }
                .sheet(isPresented: $showingListSheet) {
                        NakaiyList()
                }
                Spacer()
                Button{
                    showingListSheet.toggle()
                } label: {
                    Image("arrowRightBlk")
                }
                .sheet(isPresented: $showingListSheet) {
                        NakaiyList()
                }
            }
            .padding()
            
            //BODY
            VStack(alignment: .center) {
                Button {
                    showingDetailsSheet.toggle()
                } label: {
                    //NakaiGraphicView(season: nakaiy.season)
                    //NakaiyWheel(nakaiy: nakaiy, listMode: false, lineWidth: 1.5)
                    nakaiyWheel
                        .frame(width: 170, height:170)
                        .scaleEffect(isAnimating ? 1.05 : 1.0)
                        .animation(isAnimating ? .spring(response: 0.5, dampingFraction: 0.2, blendDuration: 0) : .default, value: isAnimating)
                        .onAppear {
                            withAnimation {
                                isAnimating = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    isAnimating = false
                                }
                            }
                        }
                }
                .sheet(isPresented: $showingDetailsSheet) {
                        NakaiyDetail(nakaiy: nakaiy)
                    }
                .frame(height: 200)
                .buttonStyle(PlainButtonStyle())
            
                VStack(alignment: .leading) {
                    HStack {
                        Rectangle()
                            .fill(Color.red)
                            .opacity(0)
                            .frame(width:10,height:40)
                        Text("\(NSLocalizedString("TodayIs",comment:"Localizable")) \(dateString)*")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.bottom, 5)
    
                    HStack {
                        Rectangle()
                            .fill(Color("orangeBk"))
                            .frame(width:10,height:50)
                        Button {
                            showingDetailsSheet.toggle()
                        } label: {
                            VStack(alignment: .leading) {
                                Text("\(currentNakaiyInfo.nDay) \(nakaiy.nakaiy)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text(nakaiy.dates.uppercased())
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }

                            
                        }
                    }
                    .padding(.bottom, 25)
                    HStack {
                        Rectangle()
                            .fill(Color.red)
                            .opacity(0)
                            .frame(width:10,height:40)
                        VStack(alignment: .leading) {
                            Text(nakaiy.number)
                                .foregroundColor(.white)
                                .font(.custom("Gelasio-Italic", size: 15))
                                .bold()
                            Text(nakaiy.description)
                                .foregroundColor(.white)
                                .font(.custom("Gelasio-Italic", size: 15))
                                .bold()
                                .padding(.bottom, 30)
                            //Today is 13 Kethi, Hulhangu - Dark clouds, frequent rains. via #nakaiynevi
                            
                            //ShareLink("", item: "Today is", message: Text("13 Kethi, Hulhangu - Dark clouds, frequent rains. via #nakaiynevi"))
                             //   .foregroundColor(Color.white)
                            
                            // the message to share
                            
                            
                            let shareMsg = "\(NSLocalizedString("TodayIs",comment:"Localizable")) \(GetOrdinal(number:  currentNakaiyInfo.nDay)) day of \(nakaiy.nakaiy), \(nakaiy.season)\n\(nakaiy.description).\nvia #nakaiynevi"
                            
                            
                            Button(action: {
                                showShareSheet = true
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                            .foregroundColor(.white)
                            }
                            .sheet(isPresented: $showShareSheet) {
                                ActivityViewController(activityItems: [shareMsg])
                            }

                            Spacer()
                            Text("*\(NSLocalizedString("Date is in",comment:"Localizable"))")
                                .font(.caption2)
                                .fontWeight(.light)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    Spacer()
                        
                }
              
            }
            .background((nakaiy.season == "Iruvaa") ? Color("greenBk"): Color("blueBk"))
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                self.dateString = getFormattedDate()
                self.currentNakaiyInfo = getCurrentNakaiyInfo(day: Date.now)
                //self.currentNakaiyInfo = nakaiyIdDay(nId: Int.random(in: 1..<26), nDay: 1)
                
                
            }
        }
        
    }
        


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView(nakaiy: nakaiythah[0])
        ContentView()
    }
}
