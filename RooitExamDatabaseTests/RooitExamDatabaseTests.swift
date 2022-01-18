//
//  RooitExamDatabaseTests.swift
//  RooitExamDatabaseTests
//
//  Created by Jeremy Xue on 2022/1/18.
//

import XCTest
@testable import RooitExam

class RooitExamDatabaseTests: XCTestCase {

    let database: Database<Article> = .init()
    
    func testDatabaseSave() {
        let items = [Article(), Article()]
        do {
            try database.save(items: items)
            let restoreItems = try database.restore()
            XCTAssertEqual(items.count, restoreItems.count)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDatabaseObsever() {
        let items = [Article(), Article()]
        database.onChanged = { changeItems in
            XCTAssertEqual(items.count, changeItems.count)
        }
        try? database.save(items: items)
    }
}
