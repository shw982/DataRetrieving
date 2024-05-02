//
//  APIRouter.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import Foundation

enum APIRouter {
    
    case getPosts
    
    private var properties: APIResource {
        switch self {
            
        case .getPosts:
            return .init(httpMethod: .get, endPoint: Endpoint.posts.rawValue)
        }
    }
    
    private var accept: String {
        return "application/json"
    }
    
    func asURLRequest() -> URLRequest {
        let url = getURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = properties.httpMethod.rawValue
        urlRequest.setValue(accept, forHTTPHeaderField: "Accept")
        return urlRequest
    }
    
    private func getURL() -> URL {
        let properties = self.properties
        
        var url = Environment.baseUrl
        url.appendPathComponent(properties.endPoint)
        return url
    }
    
}
