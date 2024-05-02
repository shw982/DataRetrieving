//
//  Environment.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import Foundation

enum Environment {
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist is not available")
        }
        return dict
    }()

    static let baseUrl: URL = {
        guard let urlString = Environment.infoDict["BASE_URL"] as? String else {
            fatalError("Base url is not found!")
        }

        guard let url = URL(string: urlString) else {
            fatalError("Base url is invalid")
        }
        return url
    }()
}
