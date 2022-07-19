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
        //startGame()
        startTimer()
        moveLeft()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(zz), userInfo: nil, repeats: true)
    }
    
    @objc func zz() {
        bullets.forEach { print($0.center) }
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
            let random = Int.random(in: 0..<10)
            
            imageView.image = UIImage(named: "bullet\(random)")
            
            return imageView
        }()
        
        return bullet
    }
    
    func moveLeft() {
        let y = CGFloat.random(in: 100..<(height - 100))
        
        let bullet = createBullets(x: width - 100, y: y)
        bullet.image = bullet.image?.withHorizontallyFlippedOrientation()
        bullets.append(bullet)
        view.addSubview(bullet)
        
        UIView.animate(
            withDuration: Double.random(in: 1..<7),
            delay: 0,
            options: [],
            animations: {
                bullet.transform = CGAffineTransform(translationX: -self.width, y: 0)
                print(bullet.center)
            }) { _ in
                bullet.removeFromSuperview()
            }
    }
    
    func moveRight() {
        let y = CGFloat.random(in: 100..<(height - 100))
        
        let bullet = createBullets(x: 0, y: y)
        view.addSubview(bullet)
        
        UIView.animate(
            withDuration: Double.random(in: 1..<7),
            delay: 0,
            options: [],
            animations: {
                bullet.transform = CGAffineTransform(translationX: self.width, y: 0)
            }) { _ in
                bullet.removeFromSuperview()
            }
    }
    
}

