//
//  BinaryHeapTests.swift
//
//
//  Created by Fang Ling on 2023/8/7.
//
import Foundation
import XCTest
@testable import Collections

final class BinaryHeapTests : XCTestCase {
  func test_is_empty() {
    var heap = BinaryHeap<Int>()
    XCTAssertTrue(heap.is_empty)
    
    heap.insert(19358)
    XCTAssertFalse(heap.is_empty)
    
    heap.remove_max()
    XCTAssertTrue(heap.is_empty)
  }
  
  func test_count() {
    var heap = BinaryHeap<Int>()
    XCTAssertEqual(heap.count, 0)
    
    heap.insert(19358)
    XCTAssertEqual(heap.count, 1)
    
    heap.insert(12321)
    XCTAssertEqual(heap.count, 2)
    
    heap.remove_max()
    XCTAssertEqual(heap.count, 1)
  }
  
  struct _Task : Comparable & Equatable {
    var name : String
    var priority : Int
    
    static func < (lhs : _Task, rhs : _Task) -> Bool {
      return lhs.priority < rhs.priority
    }
  }
  
  func test_insert() {
    var heap = BinaryHeap<_Task>()
    
    XCTAssertEqual(heap.count, 0)
    heap.insert(_Task(name: "Ssu-yen", priority: 12333))
    XCTAssertEqual(heap.count, 1)
  }
  
  func test_max() {
    var heap = BinaryHeap<Int>()
    XCTAssertNil(heap.max)
    
    heap.insert(12333)
    XCTAssertEqual(heap.max, 12333)
    
    heap.insert(12321)
    XCTAssertEqual(heap.max, 12333)
    
    heap.insert(19348)
    XCTAssertEqual(heap.max, 19348)
    
    heap.insert(19358)
    XCTAssertEqual(heap.max, 19358)
  }
  
  func test_remove() {
    var heap = BinaryHeap<Int>()
    
    heap.insert(19358)
    XCTAssertEqual(heap.remove_max(), 19358)
    
    heap.insert(12)
    heap.insert(9)
    XCTAssertEqual(heap.remove_max(), 12)
    
    heap.insert(13)
    heap.insert(1)
    heap.insert(4)
    XCTAssertEqual(heap.remove_max(), 13)
    
    let input = Array(1 ... 20).shuffled()
    for i in input {
      heap.insert(i)
    }
    print(heap.count)
    
    XCTAssertEqual(heap.remove_max(), 20)
    XCTAssertEqual(heap.remove_max(), 19)
    XCTAssertEqual(heap.remove_max(), 18)
    XCTAssertEqual(heap.remove_max(), 17)
    XCTAssertEqual(heap.remove_max(), 16)
    XCTAssertEqual(heap.remove_max(), 15)
    XCTAssertEqual(heap.remove_max(), 14)
    XCTAssertEqual(heap.remove_max(), 13)
    XCTAssertEqual(heap.remove_max(), 12)
    XCTAssertEqual(heap.remove_max(), 11)
    XCTAssertEqual(heap.remove_max(), 10)
    XCTAssertEqual(heap.remove_max(), 9)
    /* One 9 was still in the heap from before */
    XCTAssertEqual(heap.remove_max(), 9)
    XCTAssertEqual(heap.remove_max(), 8)
    XCTAssertEqual(heap.remove_max(), 7)
    XCTAssertEqual(heap.remove_max(), 6)
    XCTAssertEqual(heap.remove_max(), 5)
    XCTAssertEqual(heap.remove_max(), 4)
    /* One 4 was still in the heap from before */
    XCTAssertEqual(heap.remove_max(), 4)
    XCTAssertEqual(heap.remove_max(), 3)
    XCTAssertEqual(heap.remove_max(), 2)
    XCTAssertEqual(heap.remove_max(), 1)
    /* One 1 was still in the heap from before */
    XCTAssertEqual(heap.remove_max(), 1)
    
    XCTAssertEqual(heap.count, 0)
  }
  
  func test_max_struct() {
    var heap = BinaryHeap<_Task>()
    
    let alpha = _Task(name: "Ssu-yen", priority: 12333)
    heap.insert(alpha)
    XCTAssertEqual(alpha, heap.max)
    
    heap.insert(_Task(name: "Tzu-han", priority: 1))
    XCTAssertEqual(alpha, heap.max)
    
    let gamma = _Task(name: "Ya-hsüan", priority: 19342)
    heap.insert(gamma)
    XCTAssertEqual(gamma, heap.max)
  }
  
  func test_remove_struct() {
    var heap = BinaryHeap<_Task>()
    
    let alpha = _Task(name: "Ssu-yen", priority: 12333)
    let beta = _Task(name: "Tzu-han", priority: 1)
    let gamma = _Task(name: "Ya-hsüan", priority: 19342)
    
    heap.insert(alpha)
    heap.insert(beta)
    heap.insert(gamma)
    XCTAssertEqual(heap.remove_max(), gamma)
    XCTAssertEqual(heap.remove_max(), alpha)
    XCTAssertEqual(heap.remove_max(), beta)
  }
  
  func test_init_array() {
    var heap : BinaryHeap = [23412, 32941, 3491391, 3245, 342423]
    for i in [23412, 32941, 3491391, 3245, 342423].sorted().reversed() {
      XCTAssertEqual(heap.remove_max(), i)
    }
    
    heap = [19358]
    XCTAssertEqual(heap.remove_max(), 19358)
    XCTAssertEqual(heap.count, 0)
  }
}
