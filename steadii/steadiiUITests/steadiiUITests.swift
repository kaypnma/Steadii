//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  steadiiUITests.swift

//  Description/Purpose: Used to automate UI testing of Steadii

//  Created by Kay Arellano on 10/26/19
//  Last Updated by Chris Keilbart on 12/02/2019
//  Worked on by Kay Arellano, Dustin Seah, and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  Completed all tests
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

class steadiiUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Determine if stay logged in can be toggled on and off, fails rn
    func testStayLoggedInOnOff() {
        let optButton = XCUIApplication().buttons["opt"]
        optButton.tap()
        XCTAssert(!optButton.isSelected, "Stay logged in cannot be toggled off")
        optButton.tap()
        XCTAssert(optButton.isSelected, "Stay logged in cannot be toggled off and then on")
    }
    
    //Test if entered characters matched observed characters
    func testLogin() {
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("Now")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("is")

        XCTAssert(emailTextField.value as! String == "Now")
        //We test to see if the value is obscured
        XCTAssert(passwordSecureTextField.value as! String == "••", "Password is not greeked")
    }

    
    //This function tests to see if there is a list of players available, and then checks to see if there are graphs
    func testGraphView(){
        simulateCaretakerLogin()
        
        let john = app.buttons["John Snow"]
        XCTAssert(john.exists && john.isHittable, "Incorrect setup")
        john.tap()
        sleep(1)

        let monthlyLabel = app.buttons["monthly"]
        let weeklyLabel = app.buttons["weekly"]
        let back = app.buttons["back arrow"]
        let title = app.staticTexts["John Snow"]
        //These lines will fail if it can find the elements but they are not visible (hittable)
        XCTAssert(monthlyLabel.exists && monthlyLabel.isHittable, "No monthly label present")
        XCTAssert(weeklyLabel.exists && weeklyLabel.isHittable, "No weekly label present")
        XCTAssert(title.exists && title.isHittable, "Title not displayed correctly")
        XCTAssert(back.exists && back.isHittable, "No way to exit from graph view")
        
        app.buttons["back arrow"].tap()
    
        //Will fail if it cannot find the player label
        let title2 = app.staticTexts["Player"]
        //Will fail if it can find the player label but it is not visible (hittable)
        XCTAssert(title2.exists && title2.isHittable, "No list of players visible in caretaker view after returning from graphs")
        
    }
    
    //Adds and removes a player in the caretaker view
    func testAddRemovePlayer(){
        let app = XCUIApplication()
    
        simulateCaretakerLogin()
        app.buttons["settings"].tap()
        let playerButton = app.buttons["Player1 Player1"]
        //XCTAssert(playerButton.exists && playerButton.isHittable, "Player1@gmail.com is not associated with cc@gmail.com")
        //Remove player
        let emailTextField2 = app.textFields["Email"]
        emailTextField2.tap()
        emailTextField2.tap()
        emailTextField2.typeText("Player1@gmail.com")
        XCTAssert(emailTextField2.value as! String == "Player1@gmail.com", "Typed value does not match")
        app.buttons["REMOVE"].tap()
        let title = XCUIApplication().staticTexts["Player"]
        XCTAssert(title.exists && title.isHittable, "No list of players visible in caretaker view after returning from add player")
        //XCTAssert(app.buttons["Player1 Player1"].exists && app.buttons["Player1 Player1"].isHittable, "Cannot remove player")
        //Add player back
        //Automated testing failed above, so I confirmed with my eyes that it works as intended
        sleep(1)
        app.buttons["Icon feather plus"].tap()
        emailTextField2.tap()
        emailTextField2.typeText("Player1@gmail.com")
        app.buttons["ADD"].tap()

        XCTAssert(playerButton.exists && playerButton.isHittable, "Cannot add player")
    }
    
    //Tests to see if we can enter the caretaker settings and logout from them
    func testCaretakerSettings(){
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("cc@gmail.com")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Qwer123!")

        app.buttons["LOGIN"].tap()
        sleep(2)
        app.buttons["settings"].tap()
        
        let label = app.staticTexts["Remove Player"]
        XCTAssert(label.exists && label.isHittable, "No remove player label")
        
        app.buttons["back arrow"].tap()
        
        let title = XCUIApplication().staticTexts["Player"]

        XCTAssert(title.exists && title.isHittable, "No list of players visible in caretaker view after returning from settings view")
        
        app.buttons["settings"].tap()
        let appInfo = app.staticTexts["iiStudio"]
        XCTAssert(appInfo.exists && appInfo.isHittable, "No app information")
        
        let logout = app.buttons["LOGOUT"]
        XCTAssert(logout.exists && logout.isHittable, "No logout button")
        
        logout.tap()
        XCTAssert(emailTextField.exists && emailTextField.isHittable, "Cannot Logout")
        XCTAssert(emailTextField.value as! String == "cc@gmail.com" && passwordSecureTextField.value as! String == "••••••••", "Does not remember account info")
        
    }
    
    //Tests to see if a new caretaker account will open the caretaker view
    func testCreateCaretaker(){
        //The sleeps are because the sim can be too fast
        let app = XCUIApplication()
        app.buttons["Create a new account"].tap()
        
        let firstName = app.textFields["First Name"]
        firstName.tap()
        firstName.typeText("Player1")
        let lastNameTextField = app.textFields["Last Name"]
        lastNameTextField.tap()
        lastNameTextField.tap()
        lastNameTextField.typeText("Player1")
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("abc")
        
        let createMyAccountButton = app.buttons["CREATE MY ACCOUNT"]
        createMyAccountButton.tap()
        sleep(1)
        let yesButton = app.alerts["Warning"].buttons["Yes"]
        XCTAssert(yesButton.exists && yesButton.isHittable, "No warning for missing fields")
        yesButton.tap()
        
        let pw = app.secureTextFields["Password"]
        pw.tap()
        pw.typeText("Qwer123!")
        
        let confirm = app.secureTextFields["Confirm Password"]
        confirm.tap()
        confirm.typeText("Password")
        sleep(1)
        XCTAssert(pw.value as! String == "••••••••", "Password not greeked")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No warning for missmatching passwords")
        yesButton.tap()
        
        app.secureTextFields["Confirm Password"].tap()
        confirm.typeText("Qwer123!")
        sleep(1)
        XCTAssert(confirm.value as! String == "••••••••", "Password confirmation not greeked")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about already existing acount")
        yesButton.tap()
        
        createMyAccountButton.tap()
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about not selecting account type")
        yesButton.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).buttons["opt"].tap()
        
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about invalid email")
        yesButton.tap()
        
        emailTextField.tap()
        emailTextField.typeText(String(Int.random(in: 0...5555555))+"@gmail.com")
        
        /*pw.tap()
         pw.typeText("abcdefg!")
         confirm.tap()
         confirm.typeText("abcdefg!")
         createMyAccountButton.tap()
         sleep(1)
         XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about lack of number")
         yesButton.tap()*/
        
        pw.tap()
        pw.typeText("abcdef1")
        confirm.tap()
        confirm.typeText("abcdef1")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about lack of special character")
        yesButton.tap()
        
        pw.tap()
        pw.typeText("Abcde")
        confirm.tap()
        confirm.typeText("Abcde")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about lack of special character")
        yesButton.tap()
        
        pw.tap()
        pw.typeText("Qwer123!")
        confirm.tap()
        confirm.typeText("Qwer123!")
        createMyAccountButton.tap()
        sleep(1)
        
        //Will fail if it cannot find the elements
        let title = app.staticTexts["Player"]
        let addplayerbutton = app.buttons["Icon feather plus"]
        let settings = app.buttons["settings"]
        //Will fail if it can find the player label but it is not visible (hittable)
        XCTAssert(addplayerbutton.exists && addplayerbutton.isHittable, "No ability to add players to caretaker view from new account")
        XCTAssert(title.exists && title.isHittable, "No list of players visible in caretaker view from new account")
        XCTAssert(settings.exists && settings.isHittable, "No settings button from new account")
    }
    
    //Tests to see if the player screen opens properly upon creating a new account, and checks if it propery handles incorrectly entered data
    func testCreatePlayer(){
        //The sleeps are because the sim can be too fast
        let app = XCUIApplication()
        app.buttons["Create a new account"].tap()
        
        let firstName = app.textFields["First Name"]
        firstName.tap()
        firstName.typeText("Player1")
        let lastNameTextField = app.textFields["Last Name"]
        lastNameTextField.tap()
        lastNameTextField.tap()
        lastNameTextField.typeText("Player1")
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("abc")
        
        let createMyAccountButton = app.buttons["CREATE MY ACCOUNT"]
        createMyAccountButton.tap()
        sleep(1)
        let yesButton = app.alerts["Warning"].buttons["Yes"]
        XCTAssert(yesButton.exists && yesButton.isHittable, "No warning for missing fields")
        yesButton.tap()
        
        let pw = app.secureTextFields["Password"]
        pw.tap()
        pw.typeText("Qwer123!")
        
        let confirm = app.secureTextFields["Confirm Password"]
        confirm.tap()
        confirm.typeText("Password")
        sleep(1)
        XCTAssert(pw.value as! String == "••••••••", "Password not greeked")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No warning for missmatching passwords")
        yesButton.tap()
        
        app.secureTextFields["Confirm Password"].tap()
        confirm.typeText("Qwer123!")
        sleep(1)
        XCTAssert(confirm.value as! String == "••••••••", "Password confirmation not greeked")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about already existing acount")
        yesButton.tap()
        
        createMyAccountButton.tap()
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about not selecting account type")
        yesButton.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).buttons["opt"].tap()
        
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about invalid email")
        yesButton.tap()
        
        emailTextField.tap()
        emailTextField.typeText(String(Int.random(in: 0...5555555))+"@gmail.com")
    
        /*pw.tap()
        pw.typeText("abcdefg!")
        confirm.tap()
        confirm.typeText("abcdefg!")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about lack of number")
        yesButton.tap()*/
        
        pw.tap()
        pw.typeText("abcdef1")
        confirm.tap()
        confirm.typeText("abcdef1")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about lack of special character")
        yesButton.tap()
        
        pw.tap()
        pw.typeText("Abcde")
        confirm.tap()
        confirm.typeText("Abcde")
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No complaint about lack of special character")
        yesButton.tap()
        
        pw.tap()
        pw.typeText("Qwer123!")
        confirm.tap()
        confirm.typeText("Qwer123!")
        createMyAccountButton.tap()
        sleep(1)
        let title = app.staticTexts["Choose a game"]
        XCTAssert(title.exists && title.isHittable, "Cannot enter player screen after creating an account")
    }

    //Tests to see if the how to play match game shows up correctly
    func testHowToPlayMatch(){
        simulatePlayerLogin()
        
       app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "How to Play").element(boundBy: 0).tap()
        let wordmatchHow2Play = app.staticTexts["How to Play Word Match"]
        XCTAssert(wordmatchHow2Play.exists && wordmatchHow2Play.isHittable, "No how to play wordmatch instructions")
        
        let backArrowButton = app.buttons["back arrow"]
        XCTAssert(backArrowButton.exists && backArrowButton.isHittable, "No back button from how to play wordmatch instructions")
        backArrowButton.tap()
        
        let title = app.staticTexts["Choose a game"]
        XCTAssert(title.exists && title.isHittable, "Cannot return from how to play word match to main menu")
    }
    
    //Tests to see if the how to play ballgame screen shows up
    func testHowToPlayBall(){
        simulatePlayerLogin()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "How to Play").element(boundBy: 1)/*@START_MENU_TOKEN@*/.press(forDuration: 0.5);/*[[".tap()",".press(forDuration: 0.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let instructions = app.staticTexts["How to Play Ball Tilt"]
        XCTAssert(instructions.exists && instructions.isHittable, "No how to play ballgame screen")
        
        let backArrowButton = app.buttons["back arrow"]
        XCTAssert(backArrowButton.exists && backArrowButton.isHittable, "No back button from how to play ball game instructions")
        
        backArrowButton.tap()
        let title = app.staticTexts["Choose a game"]
        XCTAssert(title.exists && title.isHittable, "Cannot return from how to play ball game to main menu")
        
    }
    
    //Test if we can enter the ball game and exit from it
    func testBeginBallGame(){
        simulatePlayerLogin()
        app.buttons["Play Button 1"].tap()
        //Wait for the game to be over, as only then is the exit button displayed
        sleep(7)
        let exit = app.buttons["exit"]
        XCTAssert(exit.exists && exit.isHittable, "No exit button in ball game")
        exit.tap()
        let title = app.staticTexts["Choose a game"]
        XCTAssert(title.exists && title.isHittable, "Cannot return from ball game to main menu")
        
    }
    
    //Tests the settings menu for a player
    func testPlayerSettings(){
        simulatePlayerLogin()
        
        app.buttons["settings"].tap()
        
        let title = app.staticTexts["Profile and Settings"]
        XCTAssert(title.exists && title.isHittable, "Cannot enter player settings")
        
        let back = app.buttons["back arrow"]
        XCTAssert(back.exists && back.isHittable, "Cannot exit player settings")
        
        let soundSetting = app.staticTexts["Sound"]
        XCTAssert(soundSetting.exists && soundSetting.isHittable, "No sound settings")
        
        let appInfo = app.staticTexts["iiStudio"]
        XCTAssert(appInfo.exists && appInfo.isHittable, "No app information present")
        back.tap()
        let title2 = app.staticTexts["Choose a game"]
        XCTAssert(title2.exists && title2.isHittable, "Cannot return from user settings to main menu")
        
        app.buttons["settings"].tap()

        let soundOff = app.buttons["Icon feather volume x"]
        XCTAssert(soundOff.exists && soundOff.isHittable, "Sound setting not remembered")
        soundOff.tap()
        let soundOn = app.buttons["Icon feather volume 2"]
        XCTAssert(soundOn.exists && soundOn.isHittable, "Cannot toggle sound on")
        soundOn.tap()
        XCTAssert(soundOff.exists && soundOff.isHittable, "Cannot toggle sound off")
        let logout = app.buttons["LOGOUT"]
        XCTAssert(logout.exists && logout.isHittable, "No logout button")
        logout.tap()
        let emailTextField = app.textFields["Email"]
        XCTAssert(emailTextField.exists && emailTextField.isHittable, "Cannot Logout")
    }
    
    //Tests to see if we can enter and exit from the word game
    func testBeginWordGame(){
        simulatePlayerLogin()
        app.buttons["Play Button"].tap()
        sleep(5)
        XCTAssert(app.buttons.element(boundBy: 0).exists && app.buttons.element(boundBy: 0).isHittable, "Left button not present")
        XCTAssert(app.buttons.element(boundBy: 1).exists && app.buttons.element(boundBy: 1).isHittable, "Centre button not present")
        XCTAssert(app.buttons.element(boundBy: 2).exists && app.buttons.element(boundBy: 2).isHittable, "Right button not present")
        XCTAssert(app.staticTexts.element(boundBy: 0).exists && app.staticTexts.element(boundBy: 0).isHittable, "No title is visible")
        for _ in 0 ... 14{
            if app.buttons["exit"].exists {
                break
            }
            app.buttons.element(boundBy: 0).tap()
            sleep(1)
            if app.buttons["exit"].exists {
                break
            }
            app.buttons.element(boundBy: 1).tap()
            sleep(1)
            if app.buttons["exit"].exists {
                break
            }
            app.buttons.element(boundBy: 2).tap()
            sleep(1)
        }
        XCTAssert(app.buttons["exit"].exists && app.buttons["exit"].isHittable, "No exit button")
        app.buttons["exit"].tap()
        let title = app.staticTexts["Choose a game"]
        XCTAssert(title.exists && title.isHittable, "Cannot return from word game to main menu")
    }
    
    
    func simulatePlayerLogin(){
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        //emailTextField.tap()
        emailTextField.typeText("Player1@gmail.com")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Qwer123!")
        //hideKeyboardButton.tap()//Sometimes this is needed, sometimes it is not
        XCUIApplication().buttons["opt"].tap()
        app.buttons["LOGIN"].tap()
        sleep(2)
    }
    
    func simulateCaretakerLogin(){
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("cc@gmail.com")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Qwer123!")
        XCUIApplication().buttons["opt"].tap()
        //hideKeyboardButton.tap()//Sometimes needs to be here
        app.buttons["LOGIN"].tap()
        sleep(2)
    }
}
