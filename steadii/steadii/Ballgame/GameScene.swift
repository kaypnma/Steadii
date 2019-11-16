//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  GameScene.swift

//  Description/Purpose: Implementation of Ball Tilt Game

//  Created by Chris Keilbart on 10/23/19
//  Last Updated by Chris Keilbart on 11/03/2019
//  Worked on by Chris Keilbart, John Qu, Dustin Seah, Denyse Tran

//  Updates from Previous Commit:
/*
 -  New header
*/

//  Known Bugs:
/*
    None
*/

//  To do:
/*
    Add optional sound
*/

//  Copyright © 2019 ii Studio. All rights reserved.

import SpriteKit
import GameplayKit
import CoreMotion
import FirebaseDatabase

protocol gameOverDelegate : class {
    func gameIsOver()
}

// class holding the core of the Ball Game
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
    
    // Initializes the starting sizes of game elements
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
        
        // Randomizing the movement of the moving plane, can be adjusted to tune difficulty
        if planeDxDyRandom {
            planeDx = Bool.random() ? 3*Int.random(in: -14...(-8)) : 3*Int.random(in: 8...14)
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
    
    // Checks if the needed values have been initialized
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Initializes the game display and constructs the physics environment
    override func didMove(to view: SKView) {
        
        //actually center the scene to have the origin at the centre of the screen
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 250/255, green: 207/255, blue: 142/255, alpha: 1)
        
        //Creating display objects
        initializePlayer()
        initializePlane(planePosition: CGPoint(x: 0, y: 0))
        
        //Accelerometer/Gravity
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.05
        
        //Physics
        self.physicsWorld.contactDelegate = self
        initializePlanePhysics(planePhysicsVelocity: CGVector(dx: planeDx, dy: planeDy))
        
        //Display
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
    
    // Updates the game state by moving the ball, changing the plane size, and detecting if the game is over
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
            
            //Decrease the plane size to force the game to eventually end
            updatePlaneSize()
            
            //Debug code
            //print ("x: ", player.anchorPoint.x, " | ", distanceX, " | ", plane.position.x)
            //print ("y: ", player.anchorPoint.y, " | ", distanceY, " | ", plane.position.y)
            //print ("r: ", distanceX, " | ", distanceY, " | ", distanceR)
        }
    }
    
    // Checks if the plane has collided with the edge of the screen, and if it has it bounces it off
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
    
    // Reads from the gyroscope and changes the physics environment's gravity, which moves the ball
    func updateTileData (tiltdata: CMAccelerometerData) {
        physicsWorld.gravity = CGVector(dx: -tiltdata.acceleration.y * tiltSensitivity, dy: tiltdata.acceleration.x * tiltSensitivity)//Swapped and negated because of landscape
    }
    
    // Checks if any part of the user controlled ball is overlapping the plane
    func gameOver (distanceR: CGFloat) -> Bool {
        if distanceR > CGFloat(planeRadius - playerRadius) {
            //Game has ended
            plane.physicsBody?.isDynamic = false
            player.physicsBody?.isDynamic = false
            //print ("Time: ", Double(round(1000*(-startTime.timeIntervalSinceNow))/1000))
            self.isPaused = true
            
            //Outputs a game over sign when the game ends
            var gtime = 0.0
            gtime = Double(round(1000*(-startTime.timeIntervalSinceNow))/1000)
            GameOver = SKLabelNode(text: "GAME OVER\nDURATION: " + String(gtime) + " seconds")
            GameOver.numberOfLines = 0
            GameOver.fontSize = 80
            GameOver.fontName = "AvenirNext-DemiBold"
            GameOver.fontColor = UIColor.black
            //databse component, need to construct a function for future
            let ref = Database.database().reference()
            ref.child("score").child("player/bscore").setValue(gtime)
            ////
            
            self.addChild(GameOver)
            
            //notification for the exit button to appear when the game ends
            NotificationCenter.default.post(name:NSNotification.Name("ExitButtonNotification"), object:nil)
           
           
            
            
            return true
        }
        else {
            return false
        }
    }
    
    // Shrinks the plane size
    func updatePlaneSize() {
        if planeRadius > (playerRadius + minimumGap) {
            let currentVelocity = CGVector(dx: plane.physicsBody!.velocity.dx, dy: plane.physicsBody!.velocity.dy)
            planeScale *= 0.999 //Can be adjusted to control the length of the game
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
    
    // Display the ball on screen according to its position 
    func initializePlayer(textr: SKTexture = SKTexture(imageNamed: "tempball2")) {
        player = SKSpriteNode(texture: textr)
        player.setScale(0.25)
        player.position = CGPoint(x: 0, y: 0)
    }
    
    // Display the plane on screen according to it's position
    func initializePlane(planePosition: CGPoint = CGPoint(x:0, y:0)) {
        plane.name = "plane"
        plane.position = planePosition
        plane.fillColor = UIColor(red: 210/255, green: 231/255, blue: 230/255, alpha: 1)
    }
    
    // Initialize the plane's physics (it's movement, collision, and size values)
    func initializePlanePhysics(planePhysicsVelocity: CGVector = CGVector(dx: 0, dy: 0)) {
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
        player.physicsBody!.affectedByGravity = true
        player.physicsBody?.collisionBitMask = 0//This in combination with the other bitmask fixes issue 1
        
        //Control the ball's motion without gravity, useful for simulating the game
        //player.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
        plane.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(planeRadius))
        plane.physicsBody!.affectedByGravity = false
        plane.physicsBody!.linearDamping = 0
        plane.physicsBody!.mass = 0.0
        plane.physicsBody!.velocity = planePhysicsVelocity
        plane.physicsBody?.collisionBitMask = 0
    }
}
