//
//  Post.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import Foundation

struct Post: Codable, Identifiable  {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
