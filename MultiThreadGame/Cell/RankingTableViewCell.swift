//
//  RankingTableViewCell.swift
//  MultiThreadGame
//
//  Created by 권오준 on 2022/07/24.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    // MARK: - UI
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Funcs
    func updateCell(rank: Rank, index: Int) {
        updateRankLabel(index)
        scoreLabel.text = "\(rank.score)"
        updateDifficultyLabel(rank.difficulty)
    }
    
    func updateRankLabel(_ index: Int) {
        rankLabel.text = "\(index)"
        
        switch index {
        case 1: rankLabel.textColor = #colorLiteral(red: 0.8352941176, green: 0.631372549, blue: 0.1176470588, alpha: 1)
        case 2: rankLabel.textColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        case 3: rankLabel.textColor = #colorLiteral(red: 0.8039215686, green: 0.4980392157, blue: 0.1960784314, alpha: 1)
        default: break
        }
    }
    
    func updateDifficultyLabel(_ difficulty: String) {
        difficultyLabel.text = difficulty
        
        switch difficulty {
        case "easy": difficultyLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        case "medium": difficultyLabel.textColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        case "hard": difficultyLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        default: break
        }
    }
}
