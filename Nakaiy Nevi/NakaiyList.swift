//
//  NakaiyList.swift
//  Nakaiy Nevi
//
//  Created by Simon Shareef on 12/05/2023.
//

import SwiftUI

struct NakaiyList: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showNextView = false
    @State private var showingIntroView = false
    @State private var selectedItem: Nakaiy? = nil
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            //Head
            HStack {
                Rectangle()
                    .fill(Color.red)
                    .opacity(0)
                    .frame(width:5,height:40)
                VStack(alignment: .leading) {

                    Button {
                        dismiss()
                    } label: {
                        Image("arrowBackSmBlk")

                    }
                }
                Spacer()
                //            Button{
                //                showingListSheet.toggle()
                //            } label: {
                //                Image("arrowRightBlk")
                //            }
                //                .sheet(isPresented: $showingListSheet) {
                //                    NakaiyList()
                //                }
            }

            // TBH this can be just changing the frame height...but i got lazy
            if colorScheme == .dark {
                Divider()
                    .frame(height: 1)
                    .background(Color("dividerLine"))
            } else {
                Divider()
                    .frame(height: 0)
                    .background(Color("dividerLine"))
            }
            HStack {
                Rectangle()
                    .fill(Color.red)
                    .opacity(0)
                    .frame(width:0,height:40)
                VStack(alignment: .leading) {

                    Button {
                        showingIntroView.toggle()
                    } label: {
                        HStack {
                            Text("\(NSLocalizedString("Introduction",comment:"Localizable"))")
                                .foregroundColor(Color("blackTxt"))
                            Spacer()
                            Image("arrowRightBlk")
                            Rectangle()
                                .fill(Color.red)
                                .opacity(0)
                                .frame(width:0,height:30)
                        }
                        
                    }
                    .sheet(isPresented: $showingIntroView) {
                        IntroView()
                    }
                    
                }
                Spacer()

            }
           

            if colorScheme == .dark {
                Divider()
                    .frame(height: 1)
                    .background(Color("dividerLine"))
            } else {
                Divider()
                    .frame(height: 0)
                    .background(Color("dividerLine"))
            }

            // The list is here
            ScrollView {
                HStack {
                    Text("IRUVAA")
                        .fontWeight(.light)
                        .foregroundColor(Color("greenBk"))
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                VStack(spacing: 1) {
                    ForEach(nakaiythah!, id: \.self) { item in
           
                        Button {
                            selectedItem = item
                            self.showNextView.toggle()
                        } label: {
                            NakaiyRow(nakaiy: item)
                        }

                        
                        if (item.id == 9) {
                            HStack {
                                Text("HULHANGU")
                                    .fontWeight(.light)
                                    .foregroundColor(Color("blueBk"))
                
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        }
                    }
                }
                .sheet(item: $selectedItem) { item in
                        NakaiyDetail(nakaiy: item)
                }
                
            }
            .padding(.top,-8)
    

        }
        //.listStyle(.grouped)


//            List(nakaiythah) { Nakaiy in
//                let bgColor = (Nakaiy.season == "Iruvaa") ? "greenBk" : "blueBk"
//                Button {
//                    self.showNextView.toggle()
//                } label: {
//                    NakaiyRow(nakaiy: Nakaiy)
//                }
////                .background(
////                    NavigationLink(destination: NakaiyDetail(nakaiy: Nakaiy), isActive: $showNextView) {
////                        EmptyView()
////
////                    }
//////                        .padding(-10)
//////                        .hidden()
////                )
////                NavigationLink(value:Nakaiy) {
////                    NakaiyRow(nakaiy: Nakaiy)
////
////                }
////                .background(Color(bgColor))
////                .padding(-10)
//
//
//            }
//            .listStyle(.grouped)
//            .navigationDestination(for: Nakaiy.self) { Nakaiy in
//                NakaiyDetail(nakaiy: Nakaiy)
//            }
            
            
        
//        NavigationStack {
//            List(nakaiythah) { Nakaiy in
//                let bgColor = (Nakaiy.season == "Iruvaa") ? "greenBk" : "blueBk"
//                Button {
//                    self.showNextView.toggle()
//                } label: {
//                    NakaiyRow(nakaiy: Nakaiy)
//                }
//                .background(
//                    NavigationLink(destination: NakaiyDetail(nakaiy: Nakaiy), isActive: $showNextView) {
//                        EmptyView()
//
//                    }
////                        .padding(-10)
////                        .hidden()
//                )
////                NavigationLink(value:Nakaiy) {
////                    NakaiyRow(nakaiy: Nakaiy)
////
////                }
////                .background(Color(bgColor))
////                .padding(-10)
//
//
//            }
//            .listStyle(.grouped)
//            .navigationDestination(for: Nakaiy.self) { Nakaiy in
//                NakaiyDetail(nakaiy: Nakaiy)
//            }
//
//
//        }

        
    }
}

struct NakaiyList_Previews: PreviewProvider {
    static var previews: some View {
     //   ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { //deviceName in
            NakaiyList()
        //        .previewDevice(PreviewDevice(rawValue: deviceName))
       //         .previewDisplayName(deviceName)

        //}
              
    }
}
