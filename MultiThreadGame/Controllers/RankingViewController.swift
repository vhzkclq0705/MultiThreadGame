//
//  RankingViewController.swift
//  MultiThreadGame
//
//  Created by 권오준 on 2022/07/24.
//

import UIKit

class RankingViewController: UIViewController {

    // MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    let rankManager = RankManager.shared
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
        fetchRank()
    }
    
    // MARK: - Setup
    func setViewController() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let cellNib = UINib(nibName: "RankingTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "RankingTableViewCell")
    }
    
    // MARK: - Funcs
    func fetchRank() {
        rankManager.loadRank()
    }

}

// MARK: - TableView
extension RankingViewController: UITableViewDelegate,
                                 UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankManager.numOfRanks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RankingTableViewCell",
            for: indexPath) as? RankingTableViewCell else {
            return UITableViewCell()
        }
        
        let rank = rankManager.returnRank(indexPath.row)
        cell.updateCell(rank: rank, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
