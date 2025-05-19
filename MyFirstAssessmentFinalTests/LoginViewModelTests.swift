//
//  LoginViewModelTests.swift
//  MyFirstAssessmentFinal
//
//  Created by Maliha on 13.05.2025.
//

import XCTest
@testable import MyFirstAssessmentFinal

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockKeychainService: MockKeychainService!
    var mockValidator: MockValidator!
    var mockAuthService: MockAuthService!

    override func setUp() {
        super.setUp()
        
        mockKeychainService = MockKeychainService()
        mockValidator = MockValidator()
        mockAuthService = MockAuthService()
        viewModel = LoginViewModel(
            keychainService: mockKeychainService,
            validator: mockValidator,
            authService: mockAuthService as! AuthServiceProtocol
        )
    }

    override func tearDown() {
        viewModel = nil
        mockKeychainService = nil
        mockValidator = nil
        mockAuthService = nil
        super.tearDown()
    }

    func testValidate_ValidInput() {
        XCTAssertNoThrow(try viewModel.validate(email: "test@elgrocer.com", password: "password123"))
    }

    func testValidate_InvalidEmail() {
        mockValidator.shouldThrowEmailError = true
        XCTAssertThrowsError(try viewModel.validate(email: "invalid-email", password: "password123")) { error in
            XCTAssertEqual(error as? ValidationError, ValidationError.invalidEmail)
        }
    }

    func testValidate_WeakPassword() {
        mockValidator.shouldThrowPasswordError = true
        XCTAssertThrowsError(try viewModel.validate(email: "test@elgrocer.com", password: "short")) { error in
            XCTAssertEqual(error as? ValidationError, ValidationError.weakPassword)
        }
    }

    func testLogin_Success() {
        mockAuthService.shouldSucceed = true

        let expectation = self.expectation(description: "Login success")
        viewModel.login(email: "test@example.com", password: "password123") { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                XCTAssertEqual(self.mockKeychainService.savedToken, "mockAuthToken")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testLogin_Failure() {
        mockAuthService.shouldSucceed = false

        let expectation = self.expectation(description: "Login failure")
        viewModel.login(email: "wrong@example.com", password: "wrongpassword") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "Invalid credentials")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testIsUserLoggedIn_True() {
        mockKeychainService.savedToken = "mockAuthToken"
        XCTAssertTrue(viewModel.isUserLoggedIn())
    }

    func testIsUserLoggedIn_False() {
        mockKeychainService.savedToken = nil
        XCTAssertFalse(viewModel.isUserLoggedIn())
    }
}
