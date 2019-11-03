//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  steadiiTests.swift

//  Description/Purpose: Used to automate testing of Steadii

//  Created by Kay Arellano on 10/26/19
//  Last Updated by Dustin Seah on 11/01/2019

//  Updates from Previous Commit:
/*
 -  Added Header
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

import XCTest
import SpriteKit
@testable import steadii

class steadiiTests: XCTestCase {

    var sut: GameScene!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = GameScene(size: CGSize(width: 1000, height: 1000),
                        planeDxDyRandom: false)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testCheckEdgeCollision() {
        // Given
        let initialVelocity = CGVector(dx: sut.planeDx, dy: sut.planeDy)
        sut.initializePlane(planePosition: CGPoint(x: 1000, y: 1000))
        sut.initializePlanePhysics(planePhysicsVelocity: initialVelocity)
        
        // When
        sut.checkEdgeCollision(plane: sut.plane)
        let resultDx = sut.plane.physicsBody!.velocity.dx.rounded()
        let checkDx = (initialVelocity.dx == -resultDx)
        let resultDy = sut.plane.physicsBody!.velocity.dy.rounded()
        let checkDy = (initialVelocity.dy == -resultDy)
        
        // Then
        print("checkDx: ", checkDx, " : ", initialVelocity.dx, "==", -resultDx)
        print("checkDy: ", checkDy, " : ", initialVelocity.dy, "==", -resultDy)
        XCTAssert(checkDx && checkDy)
    }
    
    func testGameOver() {
        // Given
        sut.initializePlayer()
        sut.initializePlane(planePosition: CGPoint(x: 1000, y: 1000))
        let distanceX = sut.player.position.x - sut.plane.position.x
        let distanceY = sut.player.position.y - sut.plane.position.y
        let distanceR = sqrt(pow(distanceX,2) + pow(distanceY,2))
        
        // When
        let checkGameOver = ((sut.gameOver(distanceR: distanceR)) &&
                            (sut.isPaused == true) &&
                            !(sut?.GameOver == nil))
        
        // Then
        print("checkGameOver: ", checkGameOver, " : ", distanceR)
        XCTAssert(checkGameOver)
    }
    
    func testUpdatePlaneSize() {
        // Given
        sut.initializePlayer()
        sut.initializePlane()
        sut.initializePlanePhysics()
        let currentPlaneScale = sut.planeScale
        
        // When
        sut.updatePlaneSize()
        let checkPlaneScale = (sut.planeScale == currentPlaneScale * 0.999)
        let checkPlaneRadius = (sut.planeRadius == currentPlaneScale * 0.999 * sut.planeRadiusStart)
        
        // Then
        print("checkPlaneScale: ", checkPlaneScale, " : ", sut.planeScale, "==", currentPlaneScale * 0.999)
        print("checkPlaneRadius: ", checkPlaneRadius, " : ", sut.planeRadius, "==", currentPlaneScale * 0.999 * sut.planeRadiusStart)
        XCTAssert(checkPlaneScale && checkPlaneRadius)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
