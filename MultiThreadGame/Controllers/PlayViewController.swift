//
//  PlayViewController.swift
//  MultiThreadGame
//
//  Created by 권오준 on 2022/07/20.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    // MARK: - UI
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var boomImageView: UIImageView!
    @IBOutlet weak var spaceShip: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameoverView: UIView!
    @IBOutlet weak var gameoverScoreLabel: UILabel!
    @IBOutlet weak var gameoverBulletsLabel: UILabel!
    @IBOutlet weak var gameoverTotalLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    // MARK: - Property
    let rankManager = RankManager.shared
    let musicPlayer = MusicPlayer()
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var bulletLimit = 100
    var image = 1
    var difficulty: Int!
    var score = 0
    var bullets = 0
    var die = false
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
        playMusic()
        startGame()
    }
    
    // MARK: - Detect Touch moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let point = touch.location(in: backgroundView)
        
        if point.y >= 150 && point.y <= height - 50 {
            spaceShip.center = point
        }
    }
    
    // MARK: - Setup
    func setViewController() {
        DispatchQueue.main.async {
            switch self.image {
            case 0: self.spaceShip.image = UIImage(named: "ship1")
            case 1: self.spaceShip.image = UIImage(named: "ship2")
            case 2: self.spaceShip.image = UIImage(named: "ship3")
            default: break
            }
            
            switch self.difficulty {
            case 0: self.backgroundView.image = UIImage(named: "background2")
            case 1: self.backgroundView.image = UIImage(named: "background3")
            case 2: self.backgroundView.image = UIImage(named: "background4")
            default: break
            }
        }
    }
    
    // MARK: - Funcs
    func playMusic() {
        var music: String!
        switch difficulty {
        case 0: music = "easy"
        case 1: music = "medium"
        case 2: music = "hard"
        default: break
        }
        
        musicPlayer.playAudio(music)
    }
    
    func stopMusic() {
        musicPlayer.stopAudio()
    }
    
    func startGame() {
        DispatchQueue.global(qos: .userInteractive).async {
            while self.die == false {
                var sec: Float!
                switch self.difficulty {
                case 0: sec = Float.random(in: 1..<5)
                case 1: sec = Float.random(in: 0.5..<4)
                case 2: sec = Float.random(in: 0..<3)
                default: break
                }
                
                if self.bulletLimit > 0 {
                    DispatchQueue.main.async {
                        self.moveRight()
                        self.bulletLimit -= 1
                    }
                }
                
                usleep(useconds_t(sec * 100000))
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            while self.die == false {
                var sec: Float!
                switch self.difficulty {
                case 0: sec = Float.random(in: 1..<5)
                case 1: sec = Float.random(in: 0.5..<4)
                case 2: sec = Float.random(in: 0..<3)
                default: break
                }
                
                if self.bulletLimit > 0 {
                    DispatchQueue.main.async {
                        self.moveLeft()
                        self.bulletLimit -= 1
                    }
                }
                
                usleep(useconds_t(sec * 100000))
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            while self.die == false {
                switch self.difficulty {
                case 0: self.score += 1000
                case 1: self.score += 1500
                case 2: self.score += 2000
                default: break
                }
                
                DispatchQueue.main.async {
                    self.scoreLabel.text = "\(self.score)"
                }
                
                usleep(100000)
            }
        }
    }
    
    func createBullets(x: CGFloat, y: CGFloat) -> UIImageView {
        let bullet: UIImageView = {
            let imageView = UIImageView(frame: CGRect(
                x: x - 50,
                y: y,
                width: 100,
                height: 100))
            let random = Int.random(in: 1..<10)
            
            imageView.image = UIImage(named: "bullet\(random)")
            
            return imageView
        }()
        
        return bullet
    }
    
    func moveLeft() {
        let y = ceil(CGFloat.random(in: 100..<(height - 100)))
        let duration = ceil(Double.random(in: 1..<7))
        let move = (self.width + 100) / duration * 0.1
        let bullet = createBullets(x: width, y: y)
        var positionX = bullet.center.x
        let positionY = bullet.center.y
        
        bullet.image = bullet.image?.withHorizontallyFlippedOrientation()
        view.addSubview(bullet)
        
        DispatchQueue.global(qos: .userInteractive).async {
            while positionX > 0 {
                positionX -= move
                
                DispatchQueue.main.async {
                    bullet.center.x = positionX
                    let diffX = self.spaceShip.center.x - positionX
                    let diffY = self.spaceShip.center.y - positionY
                    
                    if diffX <= 10 && diffX >= -8
                        && diffY <= 10 && diffY >= -8
                        && self.die == false {
                        self.boom()
                        self.die = true
                    }
                }
                
                usleep(100000)
            }
            DispatchQueue.main.async {
                self.bullets += 1
                self.bulletLimit += 1
                bullet.removeFromSuperview()
            }
        }
        
    }
    
    func moveRight() {
        let y = ceil(CGFloat.random(in: 100..<(height - 100)))
        let duration = ceil(Double.random(in: 1..<7))
        let move = self.width / duration * 0.1
        let bullet = createBullets(x: 0, y: y)
        var positionX = bullet.center.x
        let positionY = bullet.center.y
        
        view.addSubview(bullet)
        
        DispatchQueue.global(qos: .userInteractive).async {
            while positionX < self.width {
                positionX += move
                
                DispatchQueue.main.async {
                    bullet.center.x = positionX
                    let diffX = self.spaceShip.center.x - positionX
                    let diffY = self.spaceShip.center.y - positionY
                    
                    if diffX <= 10 && diffX >= -8
                        && diffY <= 10 && diffY >= -8
                        && self.die == false {
                        self.boom()
                        self.die = true
                    }
                }
                
                usleep(100000)
            }
            DispatchQueue.main.async {
                self.bullets += 1
                self.bulletLimit += 1
                bullet.removeFromSuperview()
            }
        }
    }
    
    func boom() {
        saveRank()
        spaceShip.image = UIImage()
        boomImageView.isHidden = false
        
        musicPlayer.stopAudio()
        musicPlayer.playAudio("teemo")
        
        guard let path = Bundle.main.path(forResource: "boom", ofType: "mp4") else {
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = boomImageView.bounds
        boomImageView.layer.addSublayer(playerLayer)
        
        playerLayer.videoGravity = .resize
        player.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.musicPlayer.stopAudio()
            self.boomImageView.isHidden = true
            self.setGameOverView()
        }
    }
    
    func setGameOverView() {
        gameoverView.isHidden = false
        gameoverScoreLabel.text = "\(score)"
        gameoverBulletsLabel.text = "\(bullets * 1000)"
        gameoverTotalLabel.text = "\(score + bullets * 1000)"
    }
    
    func saveRank() {
        rankManager.saveRank(score: score, difficulty: difficulty)
    }
    
    // MARK: - Actions
    @IBAction func didTapExitButton(_ sender: Any) {
        musicPlayer.stopAudio()
        dismiss(animated: true)
    }
    
}

