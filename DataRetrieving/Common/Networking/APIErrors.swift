//
//  APIErrors.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import Foundation

enum APIErrors: Error, CustomStringConvertible {
    
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    case jsonFileNotfound
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Something went wrong!"
        case .badResponse(_):
            return "Error in connecting to the server!"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong!"
        case .jsonFileNotfound:
            return "JSON response not found"
        case .parsing:
            return "Decoding error"
        }
    }
    
    var description: String {
        /// For debugging
        switch self {
        case .unknown:
            return "Unknown error"
        case .url(let error):
            return error?.localizedDescription ?? "Session error!"
        case .parsing(let error):
            return "Parsing error: \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "Bad response with status code: \(statusCode)"
        case .jsonFileNotfound:
            return "JSON response not found!"
        }
    }
}
