//
//  vEBTreeTests.swift
//
//
//  Created by Fang Ling on 2023/3/16.
//

import XCTest
@testable import Collections

extension vEBTree {
    /* Removes all the element in ascending order */
    func items_in_ascending_order() -> [Int] {
        var res = [Int]()
        while !is_empty {
            res.append(min!)
            remove(min!)
        }
        return res
    }
}

final class vEBTreeTests: XCTestCase {
    func test_is_empty() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.is_empty, true)
        XCTAssertEqual(tree.isEmpty, true)

        tree.insert(19358)
        XCTAssertEqual(tree.is_empty, false)
        XCTAssertEqual(tree.isEmpty, false)

        tree.remove(19358)
        XCTAssertEqual(tree.is_empty, true)
        XCTAssertEqual(tree.isEmpty, true)
    }

    func test_count() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.count, 0)

        tree.insert(19358)
        XCTAssertEqual(tree.count, 1)
        tree.insert(19358)
        XCTAssertEqual(tree.count, 2)
        tree.insert(12321)
        XCTAssertEqual(tree.count, 3)

        tree.remove(19358)
        XCTAssertEqual(tree.count, 2)
        tree.remove(19358)
        XCTAssertEqual(tree.count, 1)
    }

    func test_insert_random() {
        let c = 128
        var rng = SystemRandomNumberGenerator()
        let input = (0 ..< c).shuffled(using: &rng)
        let tree = vEBTree(u: 1 << 20)
        var i = 0
        for value in input {
            XCTAssertEqual(tree.count, i)
            tree.insert(value)
            i += 1
            XCTAssertEqual(tree.count, i)
        }
        XCTAssertEqual(tree.items_in_ascending_order(), [Int](0 ..< c))
    }

    func test_min() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.min, nil)

        tree.insert(5)
        XCTAssertEqual(tree.min!, 5)

        tree.insert(12)
        XCTAssertEqual(tree.min!, 5)

        tree.insert(2)
        XCTAssertEqual(tree.min!, 2)

        tree.insert(1)
        XCTAssertEqual(tree.min!, 1)
    }

    func test_max() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.max, nil)

        tree.insert(42)
        XCTAssertEqual(tree.max!, 42)

        tree.insert(20)
        XCTAssertEqual(tree.max!, 42)

        tree.insert(63)
        XCTAssertEqual(tree.max!, 63)

        tree.insert(90)
        XCTAssertEqual(tree.max!, 90)
    }

    func test_remove_min() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.min, nil)

        tree.insert(7)
        XCTAssertEqual(tree.min, 7)
        tree.remove(tree.min!)

        tree.insert(12)
        tree.insert(9)
        XCTAssertEqual(tree.min, 9)
        tree.remove(tree.min!)

        tree.insert(13)
        tree.insert(1)
        tree.insert(4)
        XCTAssertEqual(tree.min, 1)
        tree.remove(tree.min!)

        for i in (1 ... 20).shuffled() {
            tree.insert(i)
        }

        XCTAssertEqual(tree.min, 1)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 2)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 3)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 4)
        tree.remove(tree.min!)
        // One 4 was still in the tree from before
        XCTAssertEqual(tree.min, 4)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 5)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 6)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 7)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 8)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 9)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 10)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 11)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 12)
        tree.remove(tree.min!)
        // One 12 was still in the tree from before
        XCTAssertEqual(tree.min, 12)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 13)
        tree.remove(tree.min!)
        // One 13 was still in the tree from before
        XCTAssertEqual(tree.min, 13)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 14)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 15)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 16)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 17)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 18)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 19)
        tree.remove(tree.min!)
        XCTAssertEqual(tree.min, 20)
        tree.remove(tree.min!)

        XCTAssertEqual(tree.min, nil)
    }

    func test_remove_max() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.max, nil)

        tree.insert(7)
        XCTAssertEqual(tree.max, 7)
        tree.remove(tree.max!)

        tree.insert(12)
        tree.insert(9)
        XCTAssertEqual(tree.max, 12)
        tree.remove(tree.max!)

        tree.insert(13)
        tree.insert(1)
        tree.insert(4)
        XCTAssertEqual(tree.max, 13)
        tree.remove(tree.max!)

        for i in (1 ... 20).shuffled() {
            tree.insert(i)
        }

        XCTAssertEqual(tree.max, 20)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 19)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 18)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 17)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 16)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 15)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 14)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 13)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 12)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 11)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 10)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 9)
        tree.remove(tree.max!)
        // One 9 was still in the tree from before
        XCTAssertEqual(tree.max, 9)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 8)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 7)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 6)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 5)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 4)
        tree.remove(tree.max!)
        // One 4 was still in the tree from before
        XCTAssertEqual(tree.max, 4)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 3)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 2)
        tree.remove(tree.max!)
        XCTAssertEqual(tree.max, 1)
        tree.remove(tree.max!)
        // One 1 was still in the tree from before
        XCTAssertEqual(tree.max, 1)
        tree.remove(tree.max!)

        XCTAssertEqual(tree.max, nil)
    }

    func test_remove_random() {
        let c = 256
        let tree = vEBTree(u: 1 << 20)

        for _ in 0 ..< c {
            for j in (0 ..< c).shuffled() {
                tree.insert(j)
            }
        }

        var i = c * c
        for _ in 0 ..< c {
            for j in (0 ..< c).shuffled() {
                XCTAssertEqual(tree.count, i)
                tree.remove(j)
                i -= 1
                XCTAssertEqual(tree.count, i)
            }
        }
        XCTAssertEqual(tree.count, 0)
        XCTAssertEqual(tree.items_in_ascending_order(), [])
    }

    func test_predecessor() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.predecessor(0), nil)
        XCTAssertEqual(tree.predecessor(19358), nil)

        tree.insert(19358)
        XCTAssertEqual(tree.predecessor(19358), nil)

        tree.insert(19358)
        XCTAssertEqual(tree.predecessor(19358), nil)

        tree.insert(1)
        XCTAssertEqual(tree.predecessor(19358), 1)

        tree.insert(12321)
        XCTAssertEqual(tree.predecessor(19358), 12321)

        XCTAssertEqual(tree.predecessor(1), nil)
    }

    func test_successor() {
        let tree = vEBTree(u: 1 << 20)
        /* Expect fatal error */
        //_ = tree.predecessor(1 << 20)

        XCTAssertEqual(tree.successor(0), nil)

        tree.insert(19358)
        XCTAssertEqual(tree.successor(12321), 19358)

        tree.insert(12321)
        XCTAssertEqual(tree.successor(12361), 19358)

        XCTAssertEqual(tree.successor(12308), 12321)
    }

    func test_contains() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertFalse(tree.contains(19358))
        XCTAssertFalse(tree.contains(1 << 21))

        tree.insert(19358)
        XCTAssertTrue(tree.contains(19358))

        tree.insert(12321)
        XCTAssertTrue(tree.contains(12321))

        tree.remove(19358)
        XCTAssertFalse(tree.contains(19358))
    }
}
