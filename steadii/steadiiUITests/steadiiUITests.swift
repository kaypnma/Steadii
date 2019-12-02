//  CMPT 275 Fall 2019 Group 2
//  Steadii

//  steadiiUITests.swift

//  Description/Purpose: Used to automate UI testing of Steadii

//  Created by Kay Arellano on 10/26/19
//  Last Updated by Chris Keilbart on 12/02/2019
//  Worked on by Kay Arellano, Dustin Seah, and Chris Keilbart

//  Updates from Previous Commit:
/*
 -  Added more tests about signing in
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
        XCTAssert(!optButton.isSelected, "Stay logged in is not off by default")
        optButton.tap()
        XCTAssert(optButton.isSelected, "Stay logged in cannot be toggled on")
        optButton.tap()
        XCTAssert(!optButton.isSelected, "Stay logged in cannot be toggled on and then off")
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
    
    //Determine if there is a list of players when logging in as a caretaker
    //dothis
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
    //dothis
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
    //dothis
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
    //dothis
    func testAddRemovePlayer(){
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
    
    //Tests to see if we can enter the player to remove
    func testEnterRemovePlayer(){
        simulateCaretakerLogin()
        app.buttons["settings"].tap()
        
        let emailTextField2 = app.textFields["Email"]
        emailTextField2.tap()
        emailTextField2.tap()
        emailTextField2.typeText("time")
        
        XCTAssert(emailTextField2.value as! String == "time")
    }
    
    //Tests to see if we can enter the caretaker settings and logout from them
    func testCaretakerSettings(){
        simulateCaretakerLogin()
        
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
        let emailTextField = app.textFields["Email"]
        XCTAssert(emailTextField.exists && emailTextField.isHittable, "Cannot Logout")
        
    }
    
    //Tests the ability to create an account, do this
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
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No warning for missmatching passwords")
        yesButton.tap()
        
        app.secureTextFields["Confirm Password"].tap()
        confirm.typeText("Qwer123!")
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
        createMyAccountButton.tap()
        sleep(1)
        XCTAssert(yesButton.exists && yesButton.isHittable, "No warning for missmatching passwords")
        yesButton.tap()
        
        app.secureTextFields["Confirm Password"].tap()
        confirm.typeText("Qwer123!")
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
    
    func simulatePlayerLogin(){
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("Player1@gmail.com")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Qwer123!")
        app.buttons["LOGIN"].tap()
        sleep(2)
    }
    
    func simulateCaretakerLogin(){
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("Caretaker2@gmail.com")
        
        let hideKeyboardButton = app/*@START_MENU_TOKEN@*/.buttons["Hide keyboard"]/*[[".keyboards.buttons[\"Hide keyboard\"]",".buttons[\"Hide keyboard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hideKeyboardButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Qwer123!")
        app.buttons["LOGIN"].tap()
        sleep(2)
    }
}
