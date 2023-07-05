//
//  DoublyLinkedList+Descriptions.swift
//  
//
//  Created by Fang Ling on 2023/5/12.
//

import Foundation

extension DoublyLinkedList : CustomStringConvertible {
    /* A textual representation of this instance. */
    public var description : String {
        var result = "["
        // TO-DO: Support for-in loop
        var node_ptr = self.first_ptr
        var is_first = true
        while let ptr = node_ptr {
            if is_first {
                is_first = false
            } else {
                result += ", "
            }
            print(buffer[ptr].item, terminator: "", to: &result)
            node_ptr = buffer[ptr].next
        }
        result += "]"
        return result
    }
}
