//
//  Cartoon.swift
//  finalAPP
//
//  Created by User20 on 2019/6/16.
//  Copyright © 2019 ouo. All rights reserved.
//

import Foundation

struct Cartoon: Codable {
    var name: String
    var gender: String
    var creater: String
    var imageName: String
    var intro: String
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(cartoons: [Cartoon]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(cartoons) {
            let url = Cartoon.documentsDirectory.appendingPathComponent("cartoon").appendingPathExtension("plist")
            try? data.write(to: url)
            print(cartoons)
        }
    }
    
    static func readCartoonsFromFile() -> [Cartoon]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Cartoon.documentsDirectory.appendingPathComponent("cartoon").appendingPathExtension("plist")
        if let data = try? Data(contentsOf: url), let cartoons = try? propertyDecoder.decode([Cartoon].self, from: data) {
            return cartoons
        } else {
            return nil
        }
    }
}
