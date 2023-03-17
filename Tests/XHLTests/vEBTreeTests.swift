//
//  vEBTreeTests.swift
//  
//
//  Created by Fang Ling on 2023/3/16.
//

import XCTest
@testable import XHL

final class vEBTreeTests: XCTestCase {
    func testExample() throws {
        let tree = vEBTree(u: 65536)
        for i in 0 ..< 128 {
            tree.insert(i)
            XCTAssertEqual(i, tree.maximum()!)
        }
        for i in (0 ..< 128).reversed() {
            tree.remove(i)
            if i - 1 >= 0 {
                XCTAssertEqual(i - 1, tree.maximum()!)
            }
        }
    }
}
