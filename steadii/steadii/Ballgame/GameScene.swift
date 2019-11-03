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
    None
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
    var GameOver:SKLabelNode!
    
    var prevTime:TimeInterval = 0
    let startTime = Date()
    
    var tiltSensitivity:Double
    
    var planeRadiusStart:Double
    var planeRadius:Double
    var planeScale:Double
    
    var plane:SKShapeNode
    var planeDx:Int
    var planeDy:Int
    
    var playerRadius:Double
    var minimumGap:Double
    
    init (  size: CGSize,
            PtiltSensitivity: Double = 4.0,
            planeRadiusStart: Double = 300.0,
            planeScale: Double = 1.0,
            planeDxDyRandom: Bool = true,
            planeDxDy: CGVector = CGVector(dx:10, dy:5),
            playerRadius: Double = 32.0,
            PminimumGap: Double = 5.0) {
        tiltSensitivity = PtiltSensitivity
        
        self.planeRadiusStart = planeRadiusStart
        planeRadius = planeRadiusStart
        self.planeScale = planeScale
        
        plane = SKShapeNode(circleOfRadius: CGFloat(planeRadiusStart))
        
        if planeDxDyRandom {
            planeDx = Bool.random() ? 3*Int.random(in: -14...(-8)) : 3*Int.random(in: 8...14)//Guaranteed to be not zero
            planeDy = Bool.random() ? 3*Int.random(in: -14...(-8)) : 3*Int.random(in: 8...14)
        }
        else {
            planeDx = Int(planeDxDy.dx)
            planeDy = Int(planeDxDy.dy)
        }
        
        self.playerRadius = playerRadius
        minimumGap = PminimumGap
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        //actually center the scene to have the origin at the centre of the screen
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 250/255, green: 207/255, blue: 142/255, alpha: 1)
        //Creating Objects
        
        initializePlayer()
        initializePlane(planePosition: CGPoint(x: 0, y: 0))
        
        //Accelerometer/Gravity
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.05
        
        //Physics
        self.physicsWorld.contactDelegate = self
        initializePlanePhysics(planePhysicsVelocity: CGVector(dx: planeDx, dy: planeDy))
        
        self.addChild(player)
        self.addChild(plane)
    }
    
    //Used to bounce the plane off of screen edges
    override func didSimulatePhysics() {
        let plane = childNode(withName: "plane")!
        
        checkEdgeCollision(plane: plane);
    }
    
    //Used to monitor gravity
    //Used to change the size of the plane
    //Used to test detection
    
    override func update(_ currentTime: CFTimeInterval) {
        
        if let tiltdata = manager.accelerometerData {
            updateTileData(tiltdata: tiltdata)
        }
        
        if currentTime - prevTime > (1.0/30.0){ //30 FPS gameplay
            prevTime = currentTime
            
            let distanceX = player.position.x - plane.position.x
            let distanceY = player.position.y - plane.position.y
            let distanceR = sqrt(pow(distanceX,2) + pow(distanceY,2))
            
            //Detect game over condition
            if  gameOver(distanceR: distanceR) {
                return
            }
            
            //Normal gameplay difficulty increase via plane radius decrease
            
            updatePlaneSize()
            
            //print ("x: ", player.anchorPoint.x, " | ", distanceX, " | ", plane.position.x)
            //print ("y: ", player.anchorPoint.y, " | ", distanceY, " | ", plane.position.y)
            //print ("r: ", distanceX, " | ", distanceY, " | ", distanceR)
        }
    }
    
    func checkEdgeCollision (plane: SKNode){
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
    
    func updateTileData (tiltdata: CMAccelerometerData) {
        physicsWorld.gravity = CGVector(dx: -tiltdata.acceleration.y * tiltSensitivity, dy: tiltdata.acceleration.x * tiltSensitivity)//Swaped because of landscape
    }
    
    func gameOver (distanceR: CGFloat) -> Bool {
        if distanceR > CGFloat(planeRadius - playerRadius) {
            plane.physicsBody?.isDynamic = false
            player.physicsBody?.isDynamic = false
            //print ("YOU LOSE")
            //print ("Time: ", Double(round(1000*(-startTime.timeIntervalSinceNow))/1000))
            self.isPaused = true
            
            //Outputs a game over sign when the game ends
            GameOver = SKLabelNode(text: "GAME OVER\nDURATION: " + String(Double(round(1000*(-startTime.timeIntervalSinceNow))/1000)) + " seconds")
            GameOver.numberOfLines = 0
            GameOver.fontSize = 100
            GameOver.fontName = "Corbel-Bold"
            GameOver.fontColor = UIColor.black
            
            self.addChild(GameOver)
            
            //notification for the exit button to apear when the game ends
            NotificationCenter.default.post(name:NSNotification.Name("ExitButtonNotification"), object:nil)
        
            return true
        }
        else {
            return false
        }
    }
    
    func updatePlaneSize() {
        if planeRadius > (playerRadius + minimumGap) {
            let currentVelocity = CGVector(dx: plane.physicsBody!.velocity.dx, dy: plane.physicsBody!.velocity.dy)
            planeScale *= 0.999
            planeRadius = planeScale*planeRadiusStart
            plane.setScale(CGFloat(planeScale))
            plane.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(planeRadius))
            plane.physicsBody!.affectedByGravity = false
            plane.physicsBody!.linearDamping = 0
            plane.physicsBody!.mass = 0.0
            plane.physicsBody!.velocity = currentVelocity
            plane.physicsBody!.collisionBitMask = 0
        }
    }
    
    func initializePlayer(textr: SKTexture = SKTexture(imageNamed: "tempball2")) {
        player = SKSpriteNode(texture: textr)
        player.setScale(0.25)
        player.position = CGPoint(x: 0, y: 0)
    }
    
    func initializePlane(planePosition: CGPoint = CGPoint(x:0, y:0)) {
        plane.name = "plane"
        plane.position = planePosition
        plane.fillColor = UIColor(red: 210/255, green: 231/255, blue: 230/255, alpha: 1)
    }
    
    func initializePlanePhysics(planePhysicsVelocity: CGVector = CGVector(dx: 0, dy: 0)) {
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
        player.physicsBody!.affectedByGravity = true
        player.physicsBody?.collisionBitMask = 0//Cannot bounce off of anything, this line must be in otherwise the ball freaks out
        
        //this is fake gravity because real gravity moves too fast when I test on an iMac
        //player.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
        plane.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(planeRadius))
        plane.physicsBody!.affectedByGravity = false
        plane.physicsBody!.linearDamping = 0
        plane.physicsBody!.mass = 0.0
        plane.physicsBody!.velocity = planePhysicsVelocity
        plane.physicsBody?.collisionBitMask = 0
    }
}
