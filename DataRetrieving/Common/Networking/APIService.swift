//
//  APIService.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import Foundation

protocol PostsProtocol {
    func fetchFromAPI<T: Decodable>(_ type: T.Type, completion: @escaping(Result<T, APIErrors>) -> Void)
}


struct APIService: PostsProtocol {
    
    //MARK: - Generic method to fetch from API
    
    func fetchFromAPI<T: Decodable>(_ type: T.Type, completion: @escaping(Result<T, APIErrors>) -> Void) {
        
        let urlRequest = APIRouter.getPosts.asURLRequest()

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error as? URLError {
                completion(Result.failure(APIErrors.url(error)))
                
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIErrors.badResponse(statusCode: response.statusCode)))
                
            } else {
                guard let data = data else {
                    completion(Result.failure(APIErrors.unknown))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(APIErrors.parsing(error as? DecodingError)))
                }
            }
        }
        .resume()
    }

}
