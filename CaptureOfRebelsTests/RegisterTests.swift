//
//  RegisterTests.swift
//  CaptureOfRebelsTests
//
//  Created by Javier Sánchez Daza on 22/10/2018.
//  Copyright © 2018 Javier Sánchez Daza. All rights reserved.
//

import XCTest
@testable import CaptureOfRebels

class RegisterTests: XCTestCase {
    
    // Vars needed for testing
    let persistManage = PersistRebel()
    let rebel = Rebel(name: "Luke", planet: "Polis Massa", time: Date())
    let nameUserDefaults = "regList"

    
    // Testing func prepareRegister
    func testPrepareRegister() {
        let prepare = PrepareRegister()
        let result = prepare.reg(rebel)
        
        let correctResult = "rebel \(rebel.name) on planet \(rebel.planet) at \(rebel.dateTime)"
        
        XCTAssertEqual(result, correctResult)
    }
    
    // Testing func isEmptyList
    func testIsEmptyList() {
        let isNotEmpty = self.persistManage.isEmptyList(key: nameUserDefaults)
        
        XCTAssert(isNotEmpty)
    }
    
    // Testing func save
    func testSave() {
        self.persistManage.save(rebel: rebel)
        
        let isNotEmpty = self.persistManage.isEmptyList(key: nameUserDefaults)
        
        XCTAssertTrue(isNotEmpty)
    }
}
