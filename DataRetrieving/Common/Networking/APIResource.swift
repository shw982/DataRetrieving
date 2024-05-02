//
//  APIResource.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import Foundation

struct APIResource {
    let httpMethod: HTTPMethod
    let endPoint: String
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
