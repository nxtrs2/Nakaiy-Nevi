//
//  ModelData.swift
//  Nakaiy Nevi
//
//  Created by Simon Shareef on 11/05/2023.
//

import Foundation

// Need to implement loading of localised db file
// check Localizable

var nakaiythah: [Nakaiy]? = load((NSLocalizedString("db",comment:"Localizable")))


func load<T: Decodable>(_ filename: String) -> T? {
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
        print("Couldn't find \(filename) in main bundle.")
        return nil
    }
    guard let data = try? Data(contentsOf:  file) else {
        print("Couldn't load \(filename) from main bundle.")
        return nil
    }
    let decoder = JSONDecoder()
    guard let naka = try? decoder.decode(T.self, from: data) else {
        print("Couldn't parse \(filename) as \(T.self).")
        return nil
    }
    return naka
}


//func load<T: Decodable>(_ filename: String) -> T {
//
//    //let data: Data
//
//    // set the file name path
//    guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
//
//    else {
//
//        fatalError("Couldn't find \(filename) in main bundle.")
//
//    }
//
//    // load the data into a Data object
//    guard let data = try? Data(contentsOf:  file)
//    else {
//        fatalError("Couldn't load \(filename) from main bundle:\n")
//    }
//
//    let decoder = JSONDecoder()
//
//    guard let naka = try? decoder.decode(T.self, from: data)
//    else {
//
//        fatalError("Couldn't parse \(filename) as \(T.self):\n")
//
//    }
//    return naka
//
//}
