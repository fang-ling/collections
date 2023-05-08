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
        print(ll.buffer[ll.first_ptr!])
        ll.link_first(2)
        print(ll.buffer[ll.first_ptr!])
    }
}
