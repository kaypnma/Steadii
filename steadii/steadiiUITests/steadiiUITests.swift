//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  steadiiUITests.swift

//  Description/Purpose: Used to automate UI testing of Steadii

//  Created by Kay Arellano on 10/26/19
//  Last Updated by Chris Keilbart on 11/04/2019
//  Worked on by Kay Arellano, Dustin Seah, and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  Added all of the tests
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
    
    //Test if stay logged in is off by default
    func testStayLoggedInOff() {
        let optButton = XCUIApplication().buttons["opt"]
        XCTAssert(!optButton.isSelected, "Stay logged in is not off by default")
    }
    
    //Determine if stay logged in can be toggled
    func testStayLoggedInOn() {
        let optButton = XCUIApplication().buttons["opt"]
        optButton.tap()
        XCTAssert(optButton.isSelected, "Stay logged in cannot be toggled on")
    }
    
    //Determine if stay logged in can be toggled on and off
    func testStayLoggedInOnOff() {
        let optButton = XCUIApplication().buttons["opt"]
        optButton.tap()
        optButton.tap()
        XCTAssert(!optButton.isSelected, "Stay logged in cannot be toggled on and then off")
    }
    
    //Determine if entered characters matched observed characters
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
        hideKeyboardButton.tap()

        XCTAssert(emailTextField.value as! String == "Now")
        //We test to see if the value is obscured
        XCTAssert(passwordSecureTextField.value as! String == "••", "Password is not greeked")
    }
    
    //Determine if there is a list of players when logging in as a caretaker
    func testCareView(){
        simulateCaretakerLogin()
        
        //Will fail if it cannot find the elements
        let title = XCUIApplication().staticTexts["Player"]
        let addPlayerButton = app.buttons["Icon feather plus"]
        let settings = app.buttons["settings"]
        //Will fail if it can find the player label but it is not visible (hittable)
        XCTAssert(addPlayerButton.exists && addPlayerButton.isHittable, "No ability to add players to caretaker view")
        XCTAssert(title.exists && title.isHittable, "No list of players visible in caretaker view")
        XCTAssert(settings.exists && settings.isHittable, "No settings button")
    }
    
    //This function tests to see if there are any graphs displayed
    func testGraphView(){
        simulateCaretakerLogin()
        
        //These lines will fail if it cannot find the elements
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "Kay Arellano").element(boundBy: 1).tap()
        let graphs = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let monthlyLabel = app.buttons["monthly"]
        let weeklyLabel = app.buttons["weekly"]
        let back = app.buttons["back arrow"]
        
        //These lines will fail if it can find the elements but they are not visible (hittable)
        XCTAssert(monthlyLabel.exists && monthlyLabel.isHittable, "No monthly label present")
        XCTAssert(weeklyLabel.exists && weeklyLabel.isHittable, "No weekly label present")
        XCTAssert(graphs.exists && graphs.isHittable, "No graphs present")
        XCTAssert(back.exists && back.isHittable, "No way to exit from graph view")
    }
    func testExitFromGraphs(){
        simulateCaretakerLogin()
        
        //These lines will fail if it cannot find the elements
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "Kay Arellano").element(boundBy: 1).tap()
        
        app.buttons["back arrow"].tap()
        
        //Will fail if it cannot find the player label
        let title = XCUIApplication().staticTexts["Player"]
        //Will fail if it can find the player label but it is not visible (hittable)
        XCTAssert(title.exists && title.isHittable, "No list of players visible in caretaker view after returning from graphs")
    }
    
    //Tests the ability to enter the add players menu
    func testAddPlayer()
    {
        simulateCaretakerLogin()
        app.buttons["Icon feather plus"].tap()
        let addPlayerLabel = app.staticTexts["Add a player"]
        let emailTextField2 = app.textFields["Email"]
        let addButton = app.buttons["ADD"]
        let backArrow = app.buttons["back arrow"]
        
        XCTAssert(addPlayerLabel.exists && addPlayerLabel.isHittable, "No title on add player menu")
        XCTAssert(addButton.exists && addButton.isHittable, "No add button on add player menu")
        XCTAssert(emailTextField2.exists && emailTextField2.isHittable, "No email text field on add player menu")
        XCTAssert(backArrow.exists && backArrow.isHittable, "No back arrow from add player menu")
    }
    func testAddNewPlayer(){
        simulateCaretakerLogin()
        app.buttons["Icon feather plus"].tap()
        
        let emailTextField2 = app.textFields["Email"]
        emailTextField2.tap()
        emailTextField2.tap()
        emailTextField2.typeText("aid")
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        XCTAssert(emailTextField2.value as! String == "aid")
    }
    
    //Tests to see if we can return from the add player menu
    func testReturnFromAddPlayer(){
        simulateCaretakerLogin()
        app.buttons["Icon feather plus"].tap()
        app.buttons["back arrow"].tap()
        
        //Will fail if it cannot find the player label
        let title = XCUIApplication().staticTexts["Player"]
        //Will fail if it can find the player label but it is not visible (hittable)
        XCTAssert(title.exists && title.isHittable, "No list of players visible in caretaker view after returning from add player view")
    }
    
    //Tests to see if we can enter the settings screen for the caretaker view
    func testEnterSettingsScreen(){
        simulateCaretakerLogin()
        
        app.buttons["settings"].tap()
        
        let logout = app.buttons["LOGOUT"]
        let remove = app.buttons["REMOVE"]
        let back = app.buttons["back arrow"]
        
        XCTAssert(logout.exists && logout.isHittable, "No lgoout button in settings")
        XCTAssert(remove.exists && remove.isHittable, "No remove button in settings")
        XCTAssert(back.exists && back.isHittable, "No back arrow from settings menu")
    }
    
    //Tests to see if we can enter the player to remove
    func testRemovePlayer(){
        simulateCaretakerLogin()
        app.buttons["settings"].tap()
        
        let emailTextField2 = app.textFields["Email"]
        emailTextField2.tap()
        emailTextField2.tap()
        emailTextField2.typeText("time")
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        XCTAssert(emailTextField2.value as! String == "time")
    }
    
    func testExitCaretakerSettings(){
        simulateCaretakerLogin()
        
        app.buttons["settings"].tap()
        
        app.buttons["back arrow"].tap()
        
        //Will fail if it cannot find the player label
        let title = XCUIApplication().staticTexts["Player"]
        //Will fail if it can find the player label but it is not visible (hittable)
        XCTAssert(title.exists && title.isHittable, "No list of players visible in caretaker view after returning from settings view")
    }
    
    //Tests the ability to create an account
    func testAddNewAccount(){
        app.buttons["Create a new account"].tap()
            
        let firstNameTextField = app.textFields["First Name"]
        firstNameTextField.tap()
        firstNameTextField.tap()
        firstNameTextField.typeText("good")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let lastNameTextField = app.textFields["Last Name"]
        lastNameTextField.tap()
        lastNameTextField.tap()
        lastNameTextField.typeText("men")
        hideKeyboardButton.tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("to")
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("the")
        hideKeyboardButton.tap()
        
        let confirmPasswordSecureTextField = app.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.typeText("aid")
        hideKeyboardButton.tap()
        
        XCTAssert(firstNameTextField.value as! String == "good")
        XCTAssert(lastNameTextField.value as! String == "men")
        XCTAssert(emailTextField.value as! String == "to")
        XCTAssert(passwordSecureTextField.value as! String == "•••")
        XCTAssert(confirmPasswordSecureTextField.value as! String == "•••")
    }
    
    //Tests to see if we can choose between adding a player or caretaker acount
    func testAddPlayerOrCaregiver(){
        app.buttons["Create a new account"].tap()
        let button = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).buttons["opt"]
        button.tap()
        XCTAssert(button.isSelected,"Cannot select account")
    }
    
    //Tests to see if we can choose between adding a player or caretaker acount and swap them around
    func testAddPlayerOrCaregiverSwap(){
        let app = XCUIApplication()
        app.buttons["Create a new account"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element(boundBy: 0).buttons["opt"].tap()
        element.children(matching: .other).element(boundBy: 1).buttons["opt"].tap()
        XCTAssert(element.children(matching: .other).element(boundBy: 1).buttons["opt"].isSelected && !element.children(matching: .other).element(boundBy: 0).buttons["opt"].isSelected, "Cannot swap between buttons")
    }
    
    //Tests to see if a new caretaker account will open the caretaker view
    func testCreateNewCaretaker(){
        app.buttons["Create a new account"].tap()
        
        let firstNameTextField = app.textFields["First Name"]
        firstNameTextField.tap()
        firstNameTextField.tap()
        firstNameTextField.typeText("good")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let lastNameTextField = app.textFields["Last Name"]
        lastNameTextField.tap()
        lastNameTextField.tap()
        lastNameTextField.typeText("men")
        hideKeyboardButton.tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("to")
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("the")
        hideKeyboardButton.tap()
        
        let confirmPasswordSecureTextField = app.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.typeText("aid")
        hideKeyboardButton.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).buttons["opt"].tap()
        app.buttons["CREATE MY ACCOUNT"].tap()
        
        //Will fail if it cannot find the elements
        let title = XCUIApplication().staticTexts["Player"]
        let addplayerbutton = app.buttons["Icon feather plus"]
        let settings = app.buttons["settings"]
        //Will fail if it can find the player label but it is not visible (hittable)
        XCTAssert(addplayerbutton.exists && addplayerbutton.isHittable, "No ability to add players to caretaker view from new account")
        XCTAssert(title.exists && title.isHittable, "No list of players visible in caretaker view from new account")
        XCTAssert(settings.exists && settings.isHittable, "No settings button from new account")
    }
    
    //Tests to see if the player screen opens properly upon creating a new account
    func testCreatePlayer(){
        simulateCreatePlayer()
        
        let title = app.staticTexts["Choose a game"]
        XCTAssert(title.exists && title.isHittable, "Cannot enter player screen after creating an account")
    }

    //tests to see if the how to play match game shows up correctly, these tests can be split up once login is functioning correctly
    func testHowToPlayMatch(){
        simulateCreatePlayer()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).matching(identifier: "How to Play").element(boundBy: 0).tap()
        
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
        simulateCreatePlayer()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .button).matching(identifier: "How to Play").element(boundBy: 1).tap()
        let instructions = app.staticTexts["How to Play Ball Tilt"]
        XCTAssert(instructions.exists && instructions.isHittable, "No how to play ballgame area")
        
        let backArrowButton = app.buttons["back arrow"]
        XCTAssert(backArrowButton.exists && backArrowButton.isHittable, "No back button from how to play ball game instructions")
        
        backArrowButton.tap()
        let title = app.staticTexts["Choose a game"]
        XCTAssert(title.exists && title.isHittable, "Cannot return from how to play ball game to main menu")
    }
    
    //test if we can enter the ball game and exit from it
    func testBeginBallGame(){
        simulateCreatePlayer()
        app.buttons["Play Button 1"].tap()
        //Wait for the game to be over, as only then is the exit button displayed
        sleep(2)
        let exit = app.buttons["exit"]
        XCTAssert(exit.exists && exit.isHittable, "No exit button in ball game")
        exit.tap()
        let title = app.staticTexts["Choose a game"]
        XCTAssert(title.exists && title.isHittable, "Cannot return from ball game to main menu")
    }
    
    //Tests the settings menu for a player
    func testPlayerSettings(){
        simulateCreatePlayer()
        
        app.buttons["settings"].tap()
        
        let title = app.staticTexts["Profile and Settings"]
        XCTAssert(title.exists && title.isHittable, "Cannot enter player settings")
        
        let back = app.buttons["back arrow"]
        XCTAssert(back.exists && back.isHittable, "Cannot exit player settings")
        
        back.tap()
        let title2 = app.staticTexts["Choose a game"]
        XCTAssert(title2.exists && title2.isHittable, "Cannot return from user settings to main menu")
    }
    
    //Helper function to simulate creating a player account
    func simulateCreatePlayer(){
        app.buttons["Create a new account"].tap()
        
        let firstNameTextField = app.textFields["First Name"]
        firstNameTextField.tap()
        firstNameTextField.tap()
        firstNameTextField.typeText("good")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let lastNameTextField = app.textFields["Last Name"]
        lastNameTextField.tap()
        lastNameTextField.tap()
        lastNameTextField.typeText("men")
        hideKeyboardButton.tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("to")
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("the")
        hideKeyboardButton.tap()
        
        let confirmPasswordSecureTextField = app.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.typeText("aid")
        hideKeyboardButton.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).buttons["opt"].tap()
        app.buttons["CREATE MY ACCOUNT"].tap()
    }
    
    func simulateCaretakerLogin(){
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("for")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("all")
        hideKeyboardButton.tap()
        app.buttons["LOGIN"].tap()
    }
}
