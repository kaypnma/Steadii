//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  GameViewController.swift

//  Description/Purpose: Handles the presentation and display of the ball game

//  Created by Chris Keilbart on 10/23/19
//  Last Updated by Kay Arellano on 11/16/2019
//  Worked on by Kay Arellano, Chris Keilbart, John Qu, Dustin Seah, Denyse Tran

//  Updates from Previous Commit:
/*
    Added a countdown before the game
 */

//  Known Bugs:
/*
 None
 */

//  To do:
/*
 None
 */

//  Copyright © 2019 ii Studio. All rights reserved.

import UIKit
import SpriteKit


class GameViewController: UIViewController {
    //Variables used for countdown screen
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    var seconds = 3
    var timer = Timer()
    var CountLbl: UILabel!
    
    @IBOutlet weak var ExitBallGame: UIButton!
    override func viewDidLoad() {
        self.ExitBallGame.isHidden = true
        super.viewDidLoad()
        
        //Will display the exit button when the game ends
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "ExitButtonNotification"), object:nil, queue: nil) { notification in
            self.ExitBallGame.isHidden = false
        }
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs, this is default generated Xcode code
        if let view = view as? SKView {
            let scene = SKScene(size: view.bounds.size)
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.backgroundColor = UIColor(red: 250/255, green: 207/255, blue: 142/255, alpha: 1)
            view.presentScene(scene)
        }
        dispCountdown()
    }
    
    //Start timer and initialize countdown label
    func dispCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        CountLbl = UILabel(frame: CGRect(x: w/2, y: h/2, width: w, height: h))
        CountLbl.center = CGPoint(x: w/2, y: h/2)
        CountLbl.countdownLabel()
        view.addSubview(CountLbl)
    }
    
    //Update timer and display text
    @objc func updateTimer() {
        if seconds > 0 {
            CountLbl.text = timerFormat(seconds)
        }
        else {
            CountLbl.text = "START"
        }
        if seconds >= 0 {
            seconds -= 1
        } else {
            CountLbl.removeFromSuperview()
            timer.invalidate()
            startScene()
        }
    }
    
    func timerFormat(_ time: Int) -> String {
        let seconds = Int(time) % 60
        return String(seconds)
    }
    
    func startScene() {
        if let view = view as? SKView {
            let scene = GameScene(size: view.bounds.size)
            view.showsFPS = false
            view.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            view.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
        }
    }
    
    //General game view preferences
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
