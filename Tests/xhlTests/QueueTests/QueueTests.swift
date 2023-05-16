//
//  QueueTests.swift
//  
//
//  Created by Fang Ling on 2023/5/16.
//


import Foundation
import XCTest
@testable import xhl

final class QueueTests : XCTestCase {
    func test_queue() {
        var queue = Queue<String>()
        queue.enqueue("Ssu-yen")
        XCTAssertEqual(queue.count, 1)
        XCTAssertFalse(queue.is_empty)
        XCTAssertEqual(queue.front, "Ssu-yen")
        queue.enqueue("Fang-ling")
        XCTAssertEqual(queue.dequeue(), "Ssu-yen")
        XCTAssertEqual(queue.front, "Fang-ling")
        queue.dequeue()
        
        let array = ["Ya-hsüan", "Yüan-yüeh", "Tzh-han", "Hsüeh-min"]
        for i in array {
            queue.enqueue(i)
        }
        var result : [String] = []
        while !queue.is_empty {
            result.append(queue.dequeue())
        }
        XCTAssertEqual(result, array)
        XCTAssertEqual(queue.count, 0)
        XCTAssertTrue(queue.is_empty)
    }
    
    func test_cow() {
        func address(_ object: UnsafeRawPointer) -> String {
            let address = Int(bitPattern: object)
            return String(format: "%p", address)
        }
        
        var queue = Queue<String>()
        queue.enqueue("Yüan-yüeh")
        var copied = queue
        XCTAssertEqual(address(&queue.buffer.buffer),
                       address(&copied.buffer.buffer))
    }
}
