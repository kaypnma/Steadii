//  ii Studio will be adhering to Swift’s API Design guidelines in our source code. 
//  The guidelines are defined here: https://swift.org/documentation/api-design-guidelines/

//  The following header should be on the top of all source files, simply replace things in /* */

//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  GameViewController.swift
//  Takes care of gyroscope input for ball game

//  Created by ckeilbar on 10/23/19

//  Last Updated by Dustin Seah on 11/01/2019
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
