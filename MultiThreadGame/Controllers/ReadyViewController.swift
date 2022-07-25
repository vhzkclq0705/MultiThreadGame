//
//  ReadyViewController.swift
//  MultiThreadGame
//
//  Created by 권오준 on 2022/07/20.
//

import UIKit
import AVFoundation

class ReadyViewController: UIViewController {

    // MARK: - UI
    @IBOutlet weak var spaceshipImageView: UIImageView!
    @IBOutlet weak var spaceshipLeftButton: UIButton!
    @IBOutlet weak var spaceshipRightButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyLeftButton: UIButton!
    @IBOutlet weak var difficultyRightButton: UIButton!
    
    // MARK: - Property
    let musicPlayer = MusicPlayer()
    var spaceship = 1
    var difficulty = 0
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playMusic()
    }

    // MARK: - Funcs
    func playMusic() {
        musicPlayer.playAudio("ready")
    }
    
    func stopMusic() {
        musicPlayer.stopAudio()
    }
    
    // MARK: - Actions
    @IBAction func didTapStartButton(_ sender: Any) {
        stopMusic()
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as? PlayViewController else { return }
        vc.difficulty = self.difficulty
        vc.image = self.spaceship
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
    @IBAction func didTapSpaceshipLeftButton(_ sender: Any) {
        switch spaceship {
        case 0:
            spaceship = 2
            spaceshipImageView.image = UIImage(named: "ship3")
        case 1:
            spaceship = 0
            spaceshipImageView.image = UIImage(named: "ship1")
        case 2:
            spaceship = 1
            spaceshipImageView.image = UIImage(named: "ship2")
        default: break
        }
    }
    
    @IBAction func didTapSpaceshipRightButton(_ sender: Any) {
        switch spaceship {
        case 0:
            spaceship = 1
            spaceshipImageView.image = UIImage(named: "ship2")
        case 1:
            spaceship = 2
            spaceshipImageView.image = UIImage(named: "ship3")
        case 2:
            spaceship = 0
            spaceshipImageView.image = UIImage(named: "ship1")
        default: break
        }
    }
    
    @IBAction func didTapDifficultyLeftButton(_ sender: Any) {
        switch difficulty {
        case 1:
            difficulty = 0
            difficultyLabel.text = "easy"
        case 2:
            difficulty = 1
            difficultyLabel.text = "medium"
        default: break
        }
    }
    
    @IBAction func didTapDifficultyRightButton(_ sender: Any) {
        switch difficulty {
        case 0:
            difficulty = 1
            difficultyLabel.text = "medium"
        case 1:
            difficulty = 2
            difficultyLabel.text = "hard"
        default: break
        }
    }
}
