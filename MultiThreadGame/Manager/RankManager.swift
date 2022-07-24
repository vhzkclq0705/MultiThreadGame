//
//  RankManager.swift
//  MultiThreadGame
//
//  Created by 권오준 on 2022/07/25.
//

import Foundation

class RankManager {
    
    // 싱글톤 패턴
    static let shared = RankManager()
    
    // MARK: - Property
    var rankList = [Rank]()
    
    // MARK: - Cell UI
    var numOfRanks: Int {
        return rankList.count
    }
    
    func returnRank(_ index: Int) -> Rank {
        return rankList[index]
    }
    
    // MARK: - Save and load data
    func saveRank(score: Int, difficulty: Int) {
        loadRank()
        
        let rank = Rank(score: score, difficulty: difficulty)
        rankList.append(rank)
        
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(rankList),
            forKey: "rank")
    }
    
    func loadRank() {
        guard let data = UserDefaults.standard.data(forKey: "rank") else {
            return
        }
        
        rankList = (try? PropertyListDecoder().decode([Rank].self, from: data)) ?? []
        rankList.sort(by: { $0.score > $1.score })
    }
}
