//
//  HomeCell.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import UIKit

class HomeCell: UITableViewCell {

    /// IBOutlets
    @IBOutlet weak var userIdLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    
    /// Variables
    static var identifier: String {
        return String(describing: self)
    }
    
    var post: Post? {
        didSet {
           showPostInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func showPostInfo() {
        guard let post = post else { return }
        
        if let userId = post.userId {
            self.userIdLbl.text = String(describing: userId)
        }
        if let id = post.id {
            self.idLbl.text = String(describing: id)
        }
        if let title = post.title {
            self.titleLbl.text = title
        }
        if let body = post.body {
            self.bodyLbl.text = body
        }
    }

}
