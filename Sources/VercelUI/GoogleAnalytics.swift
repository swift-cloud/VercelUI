//
//  GoogleAnalytics.swift
//
//
//  Created by Andrew Barba on 1/23/23.
//

import TokamakStaticHTML

public struct GoogleAnalytics: View {

    public let id: String

    public init(id: String) {
        self.id = id
    }

    public var body: some View {
        Group {
            HTML("script", [
                "async": "true",
                "src": "https://www.googletagmanager.com/gtag/js?id=\(id)"
            ])
            HTML("script", content:
                """
                window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());
                gtag('config', '\(id)');
                """
            )
        }
    }
}
