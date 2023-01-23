//
//  URL+Path.swift
//  
//
//  Created by Andrew Barba on 1/23/23.
//

import Foundation

extension URL {

    public static func path(_ location: String) -> URL {
        return .init(string: location.starts(with: "/") ? location : "/\(location)")!
    }
}
