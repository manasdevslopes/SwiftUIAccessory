//
//  UITestingView_UITests.swift
//  SwiftUIAccessary_UITests
//
//  Created by MANAS VIJAYWARGIYA on 27/03/22.
//

import XCTest

// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehaviour
// Naming Structure : test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then

class UITestingView_UITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        // With launch Arguments
        // app.launchArguments = ["-UITest_startSignedIn"]
        // Or, with rnvironment variables
        // app.launchEnvironment = ["-UITest_startSignedIn2" : "true"]
        // Or, directly from first signup screen
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UITestingView_signupButton_shouldNotSignIn() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: false)
        
        // When
        let navbar = app.navigationBars["Welcome"]
        
        // Then
        XCTAssertFalse(navbar.exists)
    }

    func test_UITestingView_signupButton_shouldSignIn() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        let navbar = app.navigationBars["Welcome"]
        
        // Then
        XCTAssertTrue(navbar.exists)
    }

    func test_SignedInHomeView_showAlertButton_shouldDisplayAlert() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: false)
                
        // Then
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: true)
        
        // Then
        let alert = app.alerts.firstMatch
        XCTAssertFalse(alert.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDetination() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapNavigationLink(shouldDismissDestination: false)
        
        // Then
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDetinationAndGoBack() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)
        
        // When
        tapNavigationLink(shouldDismissDestination: true)
        
        // Then
        let navbar = app.navigationBars["Welcome"]
        XCTAssertTrue(navbar.exists)
    }
    
    //func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDetinationAndGoBack2() {
        // Given
        
        // When
      //  tapNavigationLink(shouldDismissDestination: true)
        
        // Then
        //let navbar = app.navigationBars["Welcome"]
        //XCTAssertTrue(navbar.exists)
    //}
}

extension UITestingView_UITests {
    func signUpAndSignIn(shouldTypeOnKeyboard: Bool) {
        let textfield = app.textFields["SinUpTextField"]
        textfield.tap()
        
        if shouldTypeOnKeyboard {
            let keyA = app.keys["A"]
            keyA.tap()
            let keya = app.keys["a"]
            keya.tap()
            keya.tap()
        }
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SinUpButton"]
        signUpButton.tap()
    }
    
    func tapAlertButton(shouldDismissAlert: Bool) {
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        if shouldDismissAlert {
            let alert = app.alerts.firstMatch
            
            let alertOkButton = alert.buttons["AlertOkButton"]
            sleep(1)
            alertOkButton.tap()
            sleep(1)
        }
    }
    
    func tapNavigationLink(shouldDismissDestination: Bool) {
        let navLinkButton = app.buttons["NavigationLinkToDestination"]
        navLinkButton.tap()
        
        if shouldDismissDestination {
            let backButton = app.navigationBars.buttons["Welcome"]
            backButton.tap()
        }
    }
}
