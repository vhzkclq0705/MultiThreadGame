//
//  ViewController.swift
//  MultiThreadGame
//
//  Created by 권오준 on 2022/07/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var spaceShip: UIImageView!
    
    var bullets = [UIImageView]()
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var timer: Timer?
    var lastPoint: CGPoint!
    var die = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(zz), userInfo: nil, repeats: true)
    }
    
    @objc func zz() {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let point = touch.location(in: backgroundView)
        
        spaceShip.center = point
    }
    
    func startGame() {
        DispatchQueue.global(qos: .userInteractive).async {
            while self.die == false {
                let sec = Int.random(in: 1..<5)
                
                DispatchQueue.main.async {
                    self.moveRight()
                }
                usleep(useconds_t(sec * 100000))
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            while self.die == false {
                let sec = Int.random(in: 1..<5)
                
                DispatchQueue.main.async {
                    self.moveLeft()
                }
                usleep(useconds_t(sec * 100000))
            }
        }
    }
    
    func createBullets(x: CGFloat, y: CGFloat) -> UIImageView {
        let bullet: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: x, y: y, width: 100, height: 100))
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
        let bullet = createBullets(x: width - 50, y: y)
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
                    
                    if diffX <= 10 && diffX >= -10
                        && diffY <= 10 && diffY >= -10 {
                        self.die = true
                    }
                }
                usleep(100000)
            }
            DispatchQueue.main.async {
                bullet.removeFromSuperview()
            }
        }
        
    }
    
    func moveRight() {
        let y = ceil(CGFloat.random(in: 100..<(height - 100)))
        let duration = ceil(Double.random(in: 1..<7))
        let move = self.width / duration * 0.1
        let bullet = createBullets(x: -50, y: y)
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
                    
                    if diffX <= 10 && diffX >= -10
                        && diffY <= 10 && diffY >= -10 {
                        self.die = true
                    }
                }
                usleep(100000)
            }
            DispatchQueue.main.async {
                bullet.removeFromSuperview()
            }
        }
    }
    
}

