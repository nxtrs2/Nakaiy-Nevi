//
//  Nakaiy.swift
//  Nakaiy Nevi
//
//  Created by Simon Shareef on 11/05/2023.
//

import Foundation
import SwiftUI

struct Nakaiy : Decodable, Identifiable, Hashable {
    var agriculture: String
    var asterism: String
    var averages: String
    var dates: String
    var description: String
    var fishing: String
    var id: Int
    var meaning: String
    var nakaiy: String
    var number: String
    var season: String
    var weather: String
}

//extension Nakaiy {
//    func placeholder(_ id: Int) -> Nakaiy {
//        Nakaiy(agriculture: "", asterism: "", averages: "", dates: "", description: "", fishing: "", id: id, meaning: "", nakaiy: "PH", number: "", season: "", weather: "")
//    }
//}
