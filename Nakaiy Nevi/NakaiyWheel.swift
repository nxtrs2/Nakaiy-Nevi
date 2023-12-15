//
//  WheelBackground.swift
//  Nakaiy Nevi
//
//  Created by Simon Shareef on 13/05/2023.
//

import SwiftUI

/// Draw the outer-lines for the Gregorian calendar markings
/// - Returns: a path object with the lines
struct DrawOuterMarkings: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let centerX = rect.midX
        let centerY = rect.midY
        
        for i in 0..<6 {
            let angle = CGFloat(i) * .pi / 6 // Convert 30 degrees to radians (30 * pi / 180 = pi / 6)
            
            let lineStart = CGPoint(x: centerX + (rect.width / 2) * cos(angle), y: centerY + (rect.width / 2) * sin(angle))
            let lineEnd = CGPoint(x: centerX - (rect.width / 2) * cos(angle), y: centerY - (rect.width / 2) * sin(angle))
            
            path.move(to: lineStart)
            path.addLine(to: lineEnd)
        }
        
        return path
    }
}

/// Draw a sector
/// - Parameters:
///     - clockwise: draw clockwise or not (boolean)
///     - offset: degrees to offset by
///     - radius: radius of the sector
///     - fullCircle: draw a full circle of given radius (not a sector)
///- Returns: A sector / circle path
struct DrawSector: Shape {
    let clockwise: Bool
    let offset : Angle
    let radius : Double
    let fullCircle : Bool
    
    func path(in rect: CGRect) -> Path {
        
        // if fullCircle then start and end angles are 0 and 360
        let startAngle = (fullCircle) ? Angle.degrees(0) : Angle.degrees(13.33 / 2) // start of the sector
        let endAngle = (fullCircle) ? Angle.degrees(360) : Angle.degrees(-13.33 / 2) //  end of the sector

        // we use the offset to draw the sector at various angles from the start pont (which is middle-top)
        let modStart = startAngle - offset
        let modEnd = endAngle - offset
        // create a path
        var path = Path()
        // move start to centre of the view (rect.mid?)
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        // add an arc
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / radius , startAngle: modStart, endAngle: modEnd, clockwise: clockwise)
        // if this is not a request to draw a full circle then close the path
        if (!fullCircle) {
            path.closeSubpath()
        }
   
        return path
    }
    
}

/// Draw the Nakaiy Wheel gadget
/// - Parameters:
///     - nakaiy: which nakaiy we are highlighting (struct Nakaiy)
///     - listMode: are we drawing the list or just the object (boolean)
///     - lineWidth: stroke width of the gadget
///
struct NakaiyWheel: View {
    var nakaiy : Nakaiy
    var listMode : Bool
    var lineWidth : Double
    var body: some View {
        //let lineWidth = 1.0
        let adjustment = Angle.degrees(90)
        let sectorAngle = 13.33
        let sectorStart = (90 + sectorAngle)
        let nakaiyNo = nakaiy.id - 1

        VStack {
            ZStack {
                // this is the outer boundary circle
                let outCircle = DrawSector(clockwise: true, offset: adjustment, radius: 2.5, fullCircle: true)
                // draw the boundary circle
                outCircle
                    .stroke(.white, lineWidth: lineWidth)
                
                DrawOuterMarkings()
                    .stroke(.white, lineWidth: lineWidth)
                
                // Draw the initial sectors
                /* Explanation:
                    There are 27 Nakaiy therefore each nakaiy will
                    occupy 360/27 = 13.333 degrees.
                    The Nakaiy Wheel is designed so that the first
                    nakaiy is centre aligned to perpendicular (90')
                    Therefore we start with an adjusted angle of
                    90 + 13.33 = 103.00 degrees and then subtract from
                    it to draw each sector (13.33 x 0 for 1st sector,
                    13.33 x 1 for second sector and so on).
                */
                ForEach((0...26), id: \.self) { item in
                    let offset = Angle.degrees(sectorStart - sectorAngle * Double(item))
                    // We change the colour of the sectors when
                    // we pass the 8th nakaiy
                    let currentColor = (item > 8) ? Color("blueBk") : Color("greenBk")
                  
                    DrawSector(clockwise: true, offset: offset, radius: 2.5, fullCircle: false)
                        .stroke(.white, lineWidth: lineWidth)
                        .background(
                            DrawSector(clockwise: true, offset: offset, radius: 2.5, fullCircle: false)
                                .fill(currentColor)
                        )
                }
                
                // Draw the selected Nakaiy
                let adjustment = Angle.degrees(sectorStart - sectorAngle * Double(nakaiyNo))
                // If we are drawing for the listmode then we use
                // white as the indicating colour. Otherwise it is orange
                let fillColor = (listMode) ? Color(.white) : Color("orangeBk")
                DrawSector(clockwise: true, offset: adjustment, radius: 2.5, fullCircle: false)
                    .stroke(.white, lineWidth: lineWidth)
                    .background(
                        DrawSector(clockwise: true, offset: adjustment, radius: 2.5, fullCircle: false)
                            .fill(fillColor)

                    )
                
                // Define the inner circle
                let innerCircle = DrawSector(clockwise: true, offset: Angle.degrees(90), radius: 4.0, fullCircle: true)
                // and draw it
                innerCircle
                    .stroke(.white, lineWidth: lineWidth)
                
                // We use this in list mode
                let fillColor2 = (nakaiyNo > 8) ? Color("blueBk") : Color("greenBk")
                // if we are not drawing in the list mode then the innercircle is orange. Otherwise it is green or blue depending on season (nakaiyNo > 8)
                if (!listMode) {
                    innerCircle
                        .fill(Color("orangeBk"))
                } else {
                    innerCircle
                        .fill(fillColor2)
                }
                
                // If we are not drawing the list then we can draw
                // the image associated with each nakaiy - stored
                // in the Assets
                if (!listMode) {
                    GeometryReader { geometry in
                        // display the icon for the nakaiy by name
                        Image(nakaiy.nakaiy.lowercased())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: (geometry.size.width / 2))
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            .overlay (
                                Circle()
                                    .stroke(Color.white, lineWidth: lineWidth)
                                    .frame(width: geometry.size.width / 2)
                            )
                    }
                }
                

   
            }

        }

    }
        
}

struct NakaiyWheel_Previews: PreviewProvider {
  
    static var previews: some View {
        NakaiyWheel(nakaiy: nakaiythah![2], listMode: false, lineWidth: 2.0)

    }
}
