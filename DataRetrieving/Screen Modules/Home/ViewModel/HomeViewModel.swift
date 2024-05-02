//
//  HomeViewModel.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import Foundation

class HomeViewModel {
    
    /// Variables
    var didReceivePosts: (()->())?
    var didReceiveError: (()->()) = {}
    
    private var service: PostsProtocol!
    
    var posts: [Post] = [] {
        didSet {
            self.didReceivePosts?()
        }
    }
    
    /// Init
    init(service: PostsProtocol = APIService()) {
        self.service = service
        self.fetchPosts()
    }
    
    /// Fetch Posts
    func fetchPosts() {
        self.service.fetchFromAPI([Post].self) { result in
            switch result {
            case .success(let _posts):
                self.posts.append(contentsOf: _posts)
            
            case .failure(let error):
                print("Error received: \(error)")
                self.didReceiveError()
            }
        }
    }
    
}
