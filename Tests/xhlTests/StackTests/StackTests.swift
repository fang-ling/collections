//
//  StackTests.swift
//  
//
//  Created by Fang Ling on 2023/5/16.
//

import Foundation
import XCTest
@testable import xhl

final class StackTests : XCTestCase {
    func test_stack() {
        var stack = Stack<Int>()
        let array = [10, 5, 12, 7, 23, 3, 9]
        for i in array {
            stack.push(i)
        }
        var result = [Int]()
        while !stack.is_empty {
            result.append(stack.pop())
        }
        XCTAssertEqual(array.reversed(), result)
    }
}
