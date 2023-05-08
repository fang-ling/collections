//
//  DoublyLinkedList.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

struct DoublyLinkedList<Element> {
    var buffer : [Node]
    var unused : [Int]
    
    var count : Int {
        get { buffer.count - unused.count }
    }
    
    /* Pointer to first node. */
    var first_ptr : Int?
    
    /* Pointer to last node. */
    var last_ptr : Int?
    
    /* Constructs an empty list. */
    public init() {
        buffer = [Node]()
        unused = [Int]()
        first_ptr = nil
        last_ptr = nil
    }
}
