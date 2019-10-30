//
//  GameScene.swift
//  Steadii
//  Ball tilt game, currently has one edge and one ball that correctly detect when they collide, gravity must be tested.
//  Created by ckeilbar on 10/23/19.
//  Copyright © 2019 ii Studio. All rights reserved.
//

/*struct PhysicsCategory {
    static let none : UInt32 = 0;
    static let all : UInt32 = UInt32.max;
    static let player : UInt32 = 0b10;
    static let edge : UInt32 = 0b1;
}*/

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager();
    var player = SKSpriteNode();
    //var edge1 = SKSpriteNode();
    
    let tiltsensitivity = 4.0;
    var prevTime:TimeInterval = 0
    let starttime = Date();
    let planeRadiusStart = 300.0;
    var planeRadius = 300;
    var planeScale = 1.0;
    let plane = SKShapeNode(circleOfRadius: 300);
    let planeDx = Bool.random() ? 3*Int.random(in: -14...(-8)) : 3*Int.random(in: 8...14);//Guaranteed to be not zero
    let planeDy = Bool.random() ? 3*Int.random(in: -14...(-8)) : 3*Int.random(in: 8...14);
    var playerRadius = 32;
    var minimumGap = 5;
    
    override func didMove(to view: SKView) {
        
        //actually center the scene to have the origin at the centre of the screen
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        //Creating Objects
        let textr = SKTexture(imageNamed: "tempball2");
        player = SKSpriteNode(texture: textr);
        //player.position = CGPoint(x: frame.midX, y: 2*frame.midY);
        player.setScale(0.25)
        player.position = CGPoint(x: 0, y: 0);
 
        plane.name = "plane";
        plane.position = CGPoint(x: 0, y: 0);
        plane.fillColor = SKColor.green;
        
        //Accelerometer/Gravity
        manager.startAccelerometerUpdates();
        manager.accelerometerUpdateInterval = 0.05;
        
        //Physics
        self.physicsWorld.contactDelegate = self;
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2);
        player.physicsBody!.affectedByGravity = true;
        player.physicsBody?.collisionBitMask = 0;//Cannot bounce off of anything, this line must be in otherwise the ball freaks out
        //player.physicsBody?.usesPreciseCollisionDetection = true;
        
        //this is fake gravity because real gravity moves too fast when I test on an iMac
        //player.physicsBody!.velocity = CGVector(dx: 0, dy: 0);
 
        plane.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(planeRadius));
        plane.physicsBody!.isDynamic = false;
        plane.physicsBody!.linearDamping = 0;
        plane.physicsBody!.mass = 0.0;
        plane.physicsBody!.velocity = CGVector(dx: planeDx, dy: planeDy);
        
        self.addChild(player);
        //self.addChild(edge1);
        self.addChild(plane);
    }

    //Used to bounce the plane off of screen edges
    override func didSimulatePhysics() {
        let plane = childNode(withName: "plane")!
        
        if (plane.position.x > (size.width/2.0 - CGFloat(planeRadius)) &&
            plane.physicsBody!.velocity.dx > 0) ||
           (plane.position.x < (-size.width/2.0 + CGFloat(planeRadius)) &&
            plane.physicsBody!.velocity.dx < 0) {
            plane.physicsBody!.velocity.dx *= -1;
        }

        if (plane.position.y > (size.height/2.0 - CGFloat(planeRadius)) && plane.physicsBody!.velocity.dy > 0) ||
           (plane.position.y < (-size.height/2.0 + CGFloat(planeRadius)) &&
            plane.physicsBody!.velocity.dy < 0) {
            plane.physicsBody!.velocity.dy *= -1;
        }
    }
 
    //Used to change the size of the plane
    //Used to test detection
    override func update(_ currentTime: CFTimeInterval) {
        
        if let tiltdata = manager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: -tiltdata.acceleration.y * tiltsensitivity, dy: tiltdata.acceleration.x * tiltsensitivity);//Swapped because of landscape
        }
        
        if currentTime - prevTime > (1.0/30.0){ //30 FPS gameplay
            prevTime = currentTime;
            
            let distanceX = player.position.x - plane.position.x;
            let distanceY = player.position.y - plane.position.y;
            let distanceR = sqrt(pow(distanceX,2) + pow(distanceY,2));
            
            if distanceR > CGFloat(planeRadius - playerRadius) {
                //sometimes the ball and plane make a sudden jump at the end of the game
                plane.physicsBody?.isDynamic = false;
                player.physicsBody?.isDynamic = false;
                print ("YOU LOSE");
                print ("Time: ",-starttime.timeIntervalSinceNow);
                return;
            }
            
            if planeRadius > (playerRadius + minimumGap) {
                let currentVelocity = CGVector(dx: plane.physicsBody!.velocity.dx, dy: plane.physicsBody!.velocity.dy);
                // Any function you put here will execute every second
                planeScale *= 0.999;
                planeRadius = Int(planeScale*planeRadiusStart);
                plane.setScale(CGFloat(planeScale));
                plane.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(planeRadius));                plane.physicsBody!.affectedByGravity = false;
                plane.physicsBody!.linearDamping = 0;
                plane.physicsBody!.mass = 0.0;
                plane.physicsBody!.velocity = currentVelocity;
                //print("size:", planeRadius);
            }
            
            //print ("x: ", player.anchorPoint.x, " | ", distanceX, " | ", plane.position.x);
            //print ("y: ", player.anchorPoint.y, " | ", distanceY, " | ", plane.position.y);
            //print ("r: ", distanceX, " | ", distanceY, " | ", distanceR);
        }
    }
 
}

