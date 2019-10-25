//
//  GameScene.swift
//  Steadii
//  Ball tilt game, currently has one edge and one ball that correctly detect when they collide, gravity must be tested.
//  Created by ckeilbar on 10/23/19.
//  Copyright © 2019 ii Studio. All rights reserved.
//

struct PhysicsCategory {
    static let none : UInt32 = 0;
    static let all : UInt32 = UInt32.max;
    static let player : UInt32 = 0b10;
    static let edge : UInt32 = 0b1;
}

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager();
    var player = SKSpriteNode();
    var edge1 = SKSpriteNode();
    

    
    override func didMove(to view: SKView) {
        
        //Creating Objects
        let textr = SKTexture(imageNamed: "tempball");
        player = SKSpriteNode(texture: textr);
        player.position = CGPoint(x: frame.midX, y: 2*frame.midY);
        
        let dimensionsedges = CGSize(width: 10, height: 10);
        edge1 = SKSpriteNode(color: UIColor.red, size: dimensionsedges);
        edge1.position = CGPoint(x: frame.midX, y: frame.midY/10);
        
        //Accelerometer/Gravity
        manager.startAccelerometerUpdates();
        manager.accelerometerUpdateInterval = 0.05;
        if let tiltdata = manager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: tiltdata.acceleration.x * 15, dy: tiltdata.acceleration.y * 15);
        }
        self.physicsWorld.contactDelegate = self;
        
        //Physics
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2);
        player.physicsBody?.isDynamic = true;
        player.physicsBody?.categoryBitMask = PhysicsCategory.player;
        player.physicsBody?.contactTestBitMask = PhysicsCategory.edge;//Collides with edges
        player.physicsBody?.collisionBitMask = PhysicsCategory.none;//Cannot bounce off of anything
        player.physicsBody?.usesPreciseCollisionDetection = true;
        
        edge1.physicsBody = SKPhysicsBody(rectangleOf: edge1.size);
        edge1.physicsBody?.isDynamic = false;
        edge1.physicsBody?.categoryBitMask = PhysicsCategory.edge;
        edge1.physicsBody?.contactTestBitMask = PhysicsCategory.edge;//Collides with edges
        edge1.physicsBody?.collisionBitMask = PhysicsCategory.none;//Cannot bounce off of anything
        
        self.addChild(player);
        self.addChild(edge1);
    }
    
    //Function that is called when there is suspected contact
    func didBegin(_ contact: SKPhysicsContact){
        var body1: SKPhysicsBody//Sorted to be the player
        var body2: SKPhysicsBody//Sorted to be an edge
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        if ((body1.categoryBitMask & PhysicsCategory.player != 0) && (body2.categoryBitMask & PhysicsCategory.edge != 0)) {
            //we have contact, game over
            /*player.removeFromParent();//Just to see if it works*/
        }
    }
}

