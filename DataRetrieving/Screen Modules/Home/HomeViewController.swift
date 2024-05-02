//
//  HomeViewController.swift
//  DataRetrieving
//
//  Created by Sweta Jaiswal on 02/05/24.
//

import UIKit

class HomeViewController: UIViewController {

    /// IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    /// Variables
    private var currentPage = 1
    private var viewModel = HomeViewModel()
    private var postsArr = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkNetworkConnectivity()
        initialSetup()
        loadData()
    }
}


// MARK: - Private Methods

extension HomeViewController {
    
    /// Load all posts
    private func loadData() {
        activityIndicator.stopAnimating()
        
        viewModel.didReceivePosts = {
            DispatchQueue.main.async {
                self.getPosts()
                self.tableView.reloadData()
            }
        }
        viewModel.didReceiveError = {
            DispatchQueue.main.async {
                print("Error_occurred")
            }
        }
    }
    
    /// Pagination - Filter out based on userID
    private func getPosts() {
        postsArr.append(contentsOf: viewModel.posts.filter { $0.userId == currentPage })
    }
    
    /// Check if internet is connected or not
    private func checkNetworkConnectivity() {
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
           if NetworkMonitor.shared.isConnected {
               print("Connected")
           } else {
               print("Not connected")
           }
       }
    
    /// Initial UI Setup
    private func initialSetup() {
        self.title = Strings.title
        activityIndicator.startAnimating()
        self.tableView.register(UINib(nibName: Strings.HomeCell.homeCell, bundle: nil), forCellReuseIdentifier: HomeCell.identifier)
    }
}


//MARK: - UITableView DataSource & Delegates

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
            fatalError("Unable to dequeue HomeCell")
        }
        cell.post = viewModel.posts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /// Pagination
        if indexPath.row == postsArr.count - 1 {
            currentPage += 1
            getPosts()
        }
    }
}
