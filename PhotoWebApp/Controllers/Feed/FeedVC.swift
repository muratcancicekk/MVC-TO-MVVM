//
//  FeedVC.swift
//  PhotoWebApp
//
//  Created by Berkan Gezgin on 12.11.2021.
//

import UIKit

protocol FeedViewInterface: AnyObject {
    func tableViewConfigure()
    func tableViewReload()
}

final class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private lazy var viewModel = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FeedCell
        cell?.setupUI(data: viewModel.postArray?[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
extension FeedVC: FeedViewInterface {
    func tableViewReload() {
        tableView.reloadData()
    }
    
    func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
