//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  steadiiTests.swift

//  Description/Purpose: Used in automated unit tests for Steadii

//  Created by Kay Arellano on 10/26/19
//  Last Updated by Chris Keilbart on 11/14/2019
//  Worked on by Kay Arellano, Dustin Seah, John Qu, and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  Added some word game tests
*/

//  Known Bugs:
/*
    None
*/

//  To do:
/*
    Update this file with tests for the word association game
*/

//  Copyright © 2019 ii Studio. All rights reserved.

import XCTest
import SpriteKit
@testable import steadii

class steadiiTests: XCTestCase {

    var sut: GameScene!
    var sut2: WordViewController!
    var sut3: caregiverViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //Examines the ball game
        super.setUp()
        sut = GameScene(size: CGSize(width: 1000, height: 1000),
                        planeDxDyRandom: false)
        sut2 = WordViewController()
        sut3 = caregiverViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        sut2 = nil
        sut3 = nil
        super.tearDown()
    }

    //Tests to see if the plane correctly bounces off of the edges of the screen
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
    
    //Tests to see if the game ends when overlap of the ball and plane occurs
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
    
    //Tests to see if the moving plane is correctly changing size
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
    
    //We actually run the next test twice for probability reasons
    var isSecondTime = false
    var sameOrder = false
    //Tests an individual category to see if it correctly empties itself
    func testIndividualCategory(){
        var testWords = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "K"]
        let testWordsBackup = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "K"]
        var output = ["", "", "", "", "", "", "", "", "", ""]
        let name = "Nom"
        var result = ""
        var indexToRemove:Int
        var temp:Bool
        let cat = individualCategory(catName: name, assocWords: testWords)
        for i in 0 ..< cat.maxCategoryLength{
            result = cat.drawWord()
            output[i] = result
            temp = testWords.contains(result)
            XCTAssert(temp, "Result not in passed inputs")
            if temp{
                indexToRemove = testWords.index(of: result)!
                testWords.remove(at: indexToRemove)
            }
        }
        if (testWordsBackup == output && !isSecondTime){
            sameOrder = true
        }
        result = cat.drawWord()
        XCTAssert(result == "NOWORDSLEFT", "Returned a value despite being empty")
        if !isSecondTime{
            isSecondTime = true
            testIndividualCategory()
        }
        else{
            XCTAssert(!sameOrder && testWordsBackup != output, "Output is same order as input")
        }
    }
    
    //Tests catMan
    func testCatMan(){
        let catMan = categoryManager(numCats: 20)
        var returnValue:wordQuestion
        var answerInt = [Int]()
        answerInt.reserveCapacity(200)
        
        for _ in 0...199{
            returnValue = catMan.getWords()
            answerInt.append(returnValue.answerInt)
            XCTAssert([0,1,2].contains(returnValue.answerInt), "Unexpected correct index")
            XCTAssert(returnValue.categories[0] != returnValue.categories[1] && returnValue.categories[1] != returnValue.categories[2] && returnValue.categories[0] != returnValue.categories[2], "Results contain a duplicate category")
            XCTAssert(catMan.categoryNames.contains(returnValue.categories[0]) && catMan.categoryNames.contains(returnValue.categories[1]) && catMan.categoryNames.contains(returnValue.categories[2]), "Categories names are incorrect")
        }
        XCTAssert(answerInt.contains(0) && answerInt.contains(1) && answerInt.contains(2), "Always the same correct answer")
    }
    //Testing if the game properly determines if the answer is correct or not is done in the UI Tests.
    
    //Tests to see if resetGlobal correctly empties the class
    func testResetGlobal(){
        sut3.resetGlobal()
        XCTAssert(GlobalAccountInfo.email != "pls@gmail.com" && GlobalAccountInfo.name != "kmn" && GlobalAccountInfo.weeklyBallYTrend != [1.0] && GlobalAccountInfo.monthlyXTrend == [0.0,29.0], "GlobalAccountInfo not reset properly")
    }
    
    //The testing of getPlayersAndEmails and dispNamesOnButtons is done in the UI testing
    
    //Tests to see if linReg acts correctly
    func testLinReg(){
        let oneDataPoint = sut3.linReg(x: [0.1], y: [32.5], lowEnd: 0.7, highEnd: 22.1)
        XCTAssert(oneDataPoint == [32.5, 32.5], "Linear regression function does not handle one data point case")
        let realTestData = sut3.linReg(x: [0.0,0.3,0.7,1.1,1.2], y: [2.5,5.2,6.2,7.2,7.1], lowEnd: 0.0, highEnd: 1.0)
        //I used an online calculator to check the results
        XCTAssert(abs(realTestData[0]-3.301) < 0.01 && abs(realTestData[1]-(3.544+3.301)) < 0.01, "Linear regression calculation is incorrect")
    }
    
    //Tests to see if we can get a mean
    func testMean(){
        let oneValue = sut3.mean(input: [1.0])
        XCTAssert(oneValue == 1.0, "Mean cannot handle one value")
        
        let threeValues = sut3.mean(input: [0.0,1.0,2.0])
        XCTAssert(threeValues == 1.0, "Mean value gives incorrect answer")
    }
    
    //I cannot test getDate directly because it depends on the current date, which is always changing
    //So I will test if we can subtract days from an arbitrary string
    func testGetDateMinus1(){
        let yearRollover = sut3.getDateMinus1(dateOld: "20190101", i: 1.0)
        XCTAssert(yearRollover == "20181231", "Cannot calculate over year wraparound")
        
        let monthRollover = sut3.getDateMinus1(dateOld: "20181101", i: 1.0)
        XCTAssert(monthRollover == "20181031", "Cannot calculate over month wraparound")
        
        let threeDays = sut3.getDateMinus1(dateOld: "20191010", i: 3.0)
        XCTAssert(threeDays == "20191007", "Cannot subtract more than one day")
    }
    //Testing of updateData will be done in the UI testing
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
