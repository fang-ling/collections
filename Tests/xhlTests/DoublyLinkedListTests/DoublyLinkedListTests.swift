//
//  DoublyLinkedListTests.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import XCTest
@testable import xhl

final class DoublyLinkedListTests : XCTestCase {
    func test_memory() {
        var ll = DoublyLinkedList<Int>()
        
        ll.link_first(1)
        ll.link_first(2)
        ll.link_first(3)
        ll.link_first(4)
        ll.link_first(5)
        /* List now looks like:
         * 5 <---> 4 <---> 3 <---> 2 <---> 1
         * Buffer looks like:
         * [Node(item: 1, next: nil, prev: 1),     // index = 0
         *  Node(item: 2, next: 0, prev: 2),       // index = 1
         *  Node(item: 3, next: 1, prev: 3),       // index = 2
         *  Node(item: 4, next: 2, prev: 4),       // index = 3
         *  Node(item: 5, next: 3, prev: nil)]     // index = 4
         */

        ll.unlink(2) /* Remove item = 3 */
        /* List now looks like:
         * 5 <---> 4 <---> 2 <---> 1
         * Buffer looks like:
         * [Node(item: 1, next: nil, prev: 1),     // index = 0
         *  Node(item: 2, next: 0, prev: 3),       // index = 1
         *  Node(item: 5, next: 3, prev: nil),     // index = 2
         *  Node(item: 4, next: 1, prev: 2)]       // index = 3
         */

        ll.unlink(2) /* Remove item = 5 */
        /* List now looks like:
         * 4 <---> 2 <---> 1
         * Buffer looks like:
         * [Node(item: 1, next: nil, prev: 1),     // index = 0
         *  Node(item: 2, next: 0, prev: 2),       // index = 1
         *  Node(item: 4, next: 1, prev: nil)]     // index = 2
         */

        ll.unlink_last(ll.last_ptr) /* Remove item = 1 */
        /* List now looks like:
         * 4 <---> 2
         * Buffer looks like:
         * [Node(item: 4, next: 1, prev: nil),     // index = 0
         *  Node(item: 2, next: nil, prev: 0)]     // index = 1
         */
        
        ll.unlink_first(ll.first_ptr) /* Remove item = 4 */
        /* List now looks like:
         * 2
         * Buffer looks like:
         * [Node(item: 2, next: nil, prev: nil)]   // index = 0
         */
        
        ll.unlink_first(ll.first_ptr) /* Remove item = 2 */
        /* List & buffer are empty now. */

        XCTAssertEqual(ll.buffer.description, [].description)
        XCTAssertEqual(ll.description, [].description)
    }
}
