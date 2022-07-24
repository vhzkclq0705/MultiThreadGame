//
//  RankingViewController.swift
//  MultiThreadGame
//
//  Created by 권오준 on 2022/07/24.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rankList = [Rank]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    func setViewController() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let cellNib = UINib(nibName: "RankingTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "RankingTableViewCell")
        let headerNib = UINib(nibName: "RankingTableViewHeaderView", bundle: nil)
        tableView.register(
            headerNib,
            forHeaderFooterViewReuseIdentifier: "RankingTableViewHeaderView")
    }
    
    func fetchRankList() {
        guard let data = UserDefaults.standard.data(forKey: "rank") else {
            return
        }
        
//        rankList = try? PropertyListDecoder().decode([Rank.self], from: data)
    }

}

extension RankingViewController: UITableViewDelegate,
                                 UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "RankingTableViewHeaderView") as? RankingTableViewHeaderView else {
            return nil
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
