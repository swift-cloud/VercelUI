//
//  CachePolicy.swift
//  
//
//  Created by Andrew Barba on 1/23/23.
//

public struct CachePolicy {

    public let maxAge: Int

    public let staleWhileRevalidate: Int

    private init(maxAge: Int, staleWhileRevalidate: Int) {
        self.maxAge = maxAge
        self.staleWhileRevalidate = staleWhileRevalidate
    }

    public static func maxAge(_ ttl: Int, staleWhileRevalidate swr: Int = 0) -> Self {
        return .init(maxAge: ttl, staleWhileRevalidate: swr)
    }

    public static var none: Self {
        return .init(maxAge: 0, staleWhileRevalidate: 0)
    }
}
