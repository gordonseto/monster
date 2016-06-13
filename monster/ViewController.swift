//
//  ViewController.swift
//  monster
//
//  Created by Gordon Seto on 2016-06-13.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImage: MonsterImage!
    @IBOutlet weak var heartImage: DragImage!
    @IBOutlet weak var foodImage: DragImage!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:",
                                                         name: "onTargetDropped", object: nil)
        
        startTimer()
        
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        print("Item dropped on character")
    }
    
    func startTimer(){
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState(){
        penalties++
        
        if penalties == 1 {
            penalty1Img.alpha = OPAQUE
            penalty2Img.alpha = DIM_ALPHA
            penalty3Img.alpha = DIM_ALPHA
        } else if penalties == 2 {
            penalty2Img.alpha = OPAQUE
            penalty3Img.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            penalty3Img.alpha = OPAQUE
        } else {
            penalty1Img.alpha = DIM_ALPHA
            penalty2Img.alpha = DIM_ALPHA
            penalty3Img.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
        
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImage.playDeadAnimation()
    }
}
