//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  GameViewController.swift

//  Description/Purpose: Handles the presentation and display of the ball game

//  Created by Chris Keilbart on 10/23/19
//  Last Updated by Chris Keilbart on 11/03/2019
//  Worked on by Chris Keilbart, John Qu, Dustin Seah, Denyse Tran

//  Updates from Previous Commit:
/*  
   New header
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
