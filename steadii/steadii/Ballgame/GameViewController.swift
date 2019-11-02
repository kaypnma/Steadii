//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  GameViewController.swift

//  Description/Purpose: Takes care of gyroscope input for ball game

//  Created by ckeilbar on 10/23/19
//  Last Updated by Denyse Tran on 11/02/2019

//  Updates from Previous Commit:
/*  
    Added Header
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
//import GameplayKit


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
        // including entities and graphs.
        if let view = view as? SKView {
            let scene = GameScene(size: view.bounds.size)
            view.showsFPS = true
            view.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            view.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
            //Something to do with gamescene, which I do not think we are using
            /*// Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }*/
  
            }

        }
    
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
