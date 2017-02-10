//
//  ViewController.swift
//  DrawBall
//
//  Created by admin on 10/14/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var n:Int = 4
    var margin: CGFloat = 40
    var lastOnLed = 1
    var arrTag = [Int]()
    var arr = [[Int]]()
    
    @IBOutlet weak var lblNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        drawRawOfBall()
        setTagBall()
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(runningLed), userInfo: nil, repeats: true)
    }

    
    func drawRawOfBall() {
        
        arr = Array(repeating: Array(repeating: 0, count: n), count: n)
        var tag: Int = 1
        for index in 0..<n {
            for yindex in 0..<n {
                let image = UIImage(named: "green")
                let ball = UIImageView(image: image)
                
                ball.center = CGPoint(x: spaceBetweenBall() * CGFloat(index) + margin, y: spaceYBetweenBall() * CGFloat(yindex) + margin + 40)
                
                ball.tag = tag
                arr[index][yindex] = ball.tag
                
                tag += 1
                
                self.view.addSubview(ball)
            }
        }
        
    }
    
    func spaceBetweenBall() -> CGFloat {
        let space = (self.view.bounds.size.width - 2 * margin) / CGFloat(n - 1)
        return space
    }
    
    func spaceYBetweenBall() -> CGFloat {
        let space = (self.view.bounds.size.height - 40 - 2 * margin) / CGFloat(n - 1)
        return space
    }

    func runningLed() {
        
        if (lastOnLed <= (n * n)) {
            turnOnLed(tag: arrTag[lastOnLed - 1])
            lastOnLed = lastOnLed + 1
            turnOffLed(tag: arrTag[lastOnLed - 2])
        } else {
            for i in 0..<arrTag.count {
                turnOnLed(tag: arrTag[i])
            }
            lastOnLed = 1
        }
    }
    
    func turnOnLed(tag: Int) {
        if let ball = self.view.viewWithTag(tag) as? UIImageView {
            ball.image = UIImage(named: "green")
        }
    }
    
    func turnOffLed(tag: Int) {
        if let ball = self.view.viewWithTag(tag) as? UIImageView {
            ball.image = UIImage(named: "grey")
        }
    }
    
    func setTagBall() {
        
        var r = 1, imin = 0, jmin = 0, imax = n - 1, jmax = n - 1, i = 0, j = 0
        while r <= n * n {
            
            if (j < jmax && i == imin) {
                arrTag.append(arr[i][j])
                j += 1
            }
            
            if (j == jmax && i < imax) {
                arrTag.append(arr[i][j])
                i += 1
            }
            
            if (i == imax && j > jmin) {
                arrTag.append(arr[i][j])
                j -= 1
            }
            
            if (j == jmin && i > imin) {
                arrTag.append(arr[i][j])
                i -= 1
            }
            
            if (i == imin && j == jmin) {
                imin += 1
                jmin += 1
                
                imax -= 1
                jmax -= 1
                
                i = imin
                j = jmin
            }
            
            r += 1
        }
        
    }
    

}

