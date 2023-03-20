//
//  vEBTreeTests.swift
//  
//
//  Created by Fang Ling on 2023/3/16.
//

import XCTest
@testable import XHL

extension vEBTree {
    /* Removes all the element in ascending order */
    func items_in_ascending_order() -> [Int] {
        var res = [Int]()
        while !is_empty {
            res.append(minimum()!)
            remove(minimum()!)
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
        XCTAssertEqual(tree.minimum(), nil)
        
        tree.insert(5)
        XCTAssertEqual(tree.minimum()!, 5)
        
        tree.insert(12)
        XCTAssertEqual(tree.minimum()!, 5)
        
        tree.insert(2)
        XCTAssertEqual(tree.minimum()!, 2)
        
        tree.insert(1)
        XCTAssertEqual(tree.minimum()!, 1)
    }
    
    func test_max() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.maximum(), nil)
        
        tree.insert(42)
        XCTAssertEqual(tree.maximum()!, 42)
        
        tree.insert(20)
        XCTAssertEqual(tree.maximum()!, 42)
        
        tree.insert(63)
        XCTAssertEqual(tree.maximum()!, 63)
        
        tree.insert(90)
        XCTAssertEqual(tree.maximum()!, 90)
    }
    
    func test_remove_min() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.minimum(), nil)

        tree.insert(7)
        XCTAssertEqual(tree.minimum(), 7)
        tree.remove(tree.minimum()!)

        tree.insert(12)
        tree.insert(9)
        XCTAssertEqual(tree.minimum(), 9)
        tree.remove(tree.minimum()!)

        tree.insert(13)
        tree.insert(1)
        tree.insert(4)
        XCTAssertEqual(tree.minimum(), 1)
        tree.remove(tree.minimum()!)

        for i in (1 ... 20).shuffled() {
            tree.insert(i)
        }

        XCTAssertEqual(tree.minimum(), 1)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 2)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 3)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 4)
        tree.remove(tree.minimum()!)
        // One 4 was still in the tree from before
        XCTAssertEqual(tree.minimum(), 4)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 5)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 6)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 7)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 8)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 9)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 10)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 11)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 12)
        tree.remove(tree.minimum()!)
        // One 12 was still in the tree from before
        XCTAssertEqual(tree.minimum(), 12)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 13)
        tree.remove(tree.minimum()!)
        // One 13 was still in the tree from before
        XCTAssertEqual(tree.minimum(), 13)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 14)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 15)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 16)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 17)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 18)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 19)
        tree.remove(tree.minimum()!)
        XCTAssertEqual(tree.minimum(), 20)
        tree.remove(tree.minimum()!)

        XCTAssertEqual(tree.minimum(), nil)
    }
    
    func test_remove_max() {
        let tree = vEBTree(u: 1 << 20)
        XCTAssertEqual(tree.maximum(), nil)

        tree.insert(7)
        XCTAssertEqual(tree.maximum(), 7)
        tree.remove(tree.maximum()!)

        tree.insert(12)
        tree.insert(9)
        XCTAssertEqual(tree.maximum(), 12)
        tree.remove(tree.maximum()!)

        tree.insert(13)
        tree.insert(1)
        tree.insert(4)
        XCTAssertEqual(tree.maximum(), 13)
        tree.remove(tree.maximum()!)

        for i in (1 ... 20).shuffled() {
            tree.insert(i)
        }

        XCTAssertEqual(tree.maximum(), 20)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 19)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 18)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 17)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 16)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 15)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 14)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 13)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 12)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 11)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 10)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 9)
        tree.remove(tree.maximum()!)
        // One 9 was still in the tree from before
        XCTAssertEqual(tree.maximum(), 9)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 8)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 7)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 6)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 5)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 4)
        tree.remove(tree.maximum()!)
        // One 4 was still in the tree from before
        XCTAssertEqual(tree.maximum(), 4)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 3)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 2)
        tree.remove(tree.maximum()!)
        XCTAssertEqual(tree.maximum(), 1)
        tree.remove(tree.maximum()!)
        // One 1 was still in the tree from before
        XCTAssertEqual(tree.maximum(), 1)
        tree.remove(tree.maximum()!)
        
        XCTAssertEqual(tree.maximum(), nil)
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
}
