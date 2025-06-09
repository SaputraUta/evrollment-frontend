//
//  JwtDecoder.swift
//  Evrollment
//
//  Created by Saputra on 09/06/25.
//

import Foundation

func decode(jwtToken token: String) -> [String: Any]? {
    let segments = token.components(separatedBy: ".")
    guard segments.count == 3 else { return nil }
    
    var base64String = segments[1]
    
    base64String = base64String
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")
    
    while base64String.count % 4 != 0 {
        base64String += "="
    }
    
    guard let data = Data(base64Encoded: base64String) else { return nil }
    
    return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
}
