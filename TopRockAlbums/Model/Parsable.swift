//
//  Parsable.swift
//  TopRockAlbums
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class Parsable: Codable {
    func jsonData() -> Data? {
        var data: Data? = nil
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            data = try encoder.encode(self)
        } catch {
            print("Encoding endoce error \(error)")
        }
        return data
    }
    
    static func parse(json: Data, completion: @escaping (Self?, Error?)->Void){
        var ret: Self? = nil
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            ret = try decoder.decode(Self.self, from: json)
            completion(ret, nil)
            return
        } catch {
            print("Decoding error \(error)")
            completion(nil, error)
            return
        }
    }
}
