//
//  DoublyLinkedListTests.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import XCTest
@testable import xhl

final class DoublyLinkedListTests : XCTestCase {
    func test() {
        var ll = DoublyLinkedList<Int>()
        ll.link_first(1)
        ll.link_first(2)
        ll.link_first(3)
        ll.link_first(4)
        ll.link_first(5)
        var array = [Int]()
        for _ in 0 ..< 5 {
            array.append(ll.unlink_first())
        }
        XCTAssertEqual(array, [5, 4, 3, 2, 1])
    }
}
