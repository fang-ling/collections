//
//  DoublyLinkedList.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

struct DoublyLinkedList<Element> {
    var buffer : [Node]
    
    var count = 0
    
    /* Pointer to first node. */
    var first_ptr : Int?
    
    /* Pointer to last node. */
    var last_ptr : Int?
    
    /* Constructs an empty list. */
    @inlinable public init() {
        buffer = [Node]()
        first_ptr = nil
        last_ptr = nil
    }
    
    @inlinable init(_ elements : [Element]) {
        self.init()
        for element in elements {
            append(element)
        }
    }
}
