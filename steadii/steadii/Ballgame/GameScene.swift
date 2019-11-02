//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  GameScene.swift

//  Description/Purpose: Implementation of Ball Tilt Game

//  Created by ckeilbar on 10/23/19
//  Last Updated by Denyse Tran on 11/02/2019

//  Updates from Previous Commit:
/*
 -  Altered code to comply with the coding standard
*/

//  Known Bugs:
/*
    None
*/

//  To do:
/*
 - Test Gravity
*/

//  Copyright © 2019 ii Studio. All rights reserved.

import SpriteKit
import GameplayKit
import CoreMotion


protocol gameOverDelegate : class {
    func gameIsOver()
}
class GameScene: SKScene, SKPhysicsContactDelegate {
    //@IBOutlet weak var exitbutton: UIButton!
    
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    //var edge1 = SKSpriteNode()
    var GameOver:SKLabelNode!
    
    let tiltSensitivity = 4.0
    var prevTime:TimeInterval = 0
    let startTime = Date()
    let planeRadiusStart = 300.0
    var planeRadius = 300
    var planeScale = 1.0
    let plane = SKShapeNode(circleOfRadius: 300)
    let planeDx = Bool.random() ? 3*Int.random(in: -14...(-8)) : 3*Int.random(in: 8...14)//Guaranteed to be not zero
    let planeDy = Bool.random() ? 3*Int.random(in: -14...(-8)) : 3*Int.random(in: 8...14)
    var playerRadius = 32
    var minimumGap = 5
    
    override func didMove(to view: SKView) {
        
        //actually center the scene to have the origin at the centre of the screen
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 250/255, green: 207/255, blue: 142/255, alpha: 1)
        //Creating Objects
        let textr = SKTexture(imageNamed: "tempball2")
        player = SKSpriteNode(texture: textr)
        player.setScale(0.25)
        player.position = CGPoint(x: 0, y: 0)
        
        plane.name = "plane"
        plane.position = CGPoint(x: 0, y: 0)
        plane.fillColor = UIColor(red: 210/255, green: 231/255, blue: 230/255, alpha: 1)
        
        //Accelerometer/Gravity
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.05
        
        //Physics
        self.physicsWorld.contactDelegate = self
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
        player.physicsBody!.affectedByGravity = true
        player.physicsBody?.collisionBitMask = 0//Cannot bounce off of anything, this line must be in otherwise the ball freaks out
        
        //this is fake gravity because real gravity moves too fast when I test on an iMac
        //player.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
        plane.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(planeRadius))
        plane.physicsBody!.affectedByGravity = false
        plane.physicsBody!.linearDamping = 0
        plane.physicsBody!.mass = 0.0
        plane.physicsBody!.velocity = CGVector(dx: planeDx, dy: planeDy)
        plane.physicsBody?.collisionBitMask = 0
        
        self.addChild(player)
        self.addChild(plane)
    }
    
    //Used to bounce the plane off of screen edges
    override func didSimulatePhysics() {
        let plane = childNode(withName: "plane")!
        
        if (plane.position.x > (size.width/2.0 - CGFloat(planeRadius)) &&
            plane.physicsBody!.velocity.dx > 0) ||
            (plane.position.x < (-size.width/2.0 + CGFloat(planeRadius)) &&
                plane.physicsBody!.velocity.dx < 0) {
            plane.physicsBody!.velocity.dx *= -1
        }
        
        if (plane.position.y > (size.height/2.0 - CGFloat(planeRadius)) && plane.physicsBody!.velocity.dy > 0) ||
            (plane.position.y < (-size.height/2.0 + CGFloat(planeRadius)) &&
                plane.physicsBody!.velocity.dy < 0) {
            plane.physicsBody!.velocity.dy *= -1
        }
    }
    
    //Used to monitor gravity
    //Used to change the size of the plane
    //Used to test detection
    
    override func update(_ currentTime: CFTimeInterval) {
        
        if let tiltdata = manager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: -tiltdata.acceleration.y * tiltSensitivity, dy: tiltdata.acceleration.x * tiltSensitivity)//Swapped because of landscape
        }
        
        if currentTime - prevTime > (1.0/30.0){ //30 FPS gameplay
            prevTime = currentTime
            
            let distanceX = player.position.x - plane.position.x
            let distanceY = player.position.y - plane.position.y
            let distanceR = sqrt(pow(distanceX,2) + pow(distanceY,2))
            
            //Detect game over condition
            if distanceR > CGFloat(planeRadius - playerRadius) {
                //sometimes the ball and plane make a sudden jump at the end of the game
                plane.physicsBody?.isDynamic = false
                player.physicsBody?.isDynamic = false
                print ("YOU LOSE")
                print ("Time: ", Double(round(1000*(-startTime.timeIntervalSinceNow))/1000))
                self.isPaused = true
                
                //Outputs a game over sign when the game ends
                GameOver = SKLabelNode(text: "GAME OVER")
                GameOver.fontSize = 100
                GameOver.fontName = "Corbel-Bold"
                GameOver.fontColor = UIColor.black
                
                self.addChild(GameOver)
                
                //notification for the exit button to appear when the game ends
            NotificationCenter.default.post(name:NSNotification.Name("ExitButtonNotification"), object:nil)
                
                return
            }
            
            //Normal gameplay difficulty increase via plane radius decrease
            if planeRadius > (playerRadius + minimumGap) {
                let currentVelocity = CGVector(dx: plane.physicsBody!.velocity.dx, dy: plane.physicsBody!.velocity.dy)
                // Any function you put here will execute every second
                planeScale *= 0.999
                planeRadius = Int(planeScale*planeRadiusStart)
                plane.setScale(CGFloat(planeScale))
                plane.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(planeRadius))
                plane.physicsBody!.affectedByGravity = false
                plane.physicsBody!.linearDamping = 0
                plane.physicsBody!.mass = 0.0
                plane.physicsBody!.velocity = currentVelocity
                plane.physicsBody!.collisionBitMask = 0
                //print("size:", planeRadius)
            }
            
            //print ("x: ", player.anchorPoint.x, " | ", distanceX, " | ", plane.position.x)
            //print ("y: ", player.anchorPoint.y, " | ", distanceY, " | ", plane.position.y)
            print ("r: ", distanceX, " | ", distanceY, " | ", distanceR)
            print ("lose distance: ", CGFloat(planeRadius - playerRadius))
        }
    }
    
}
