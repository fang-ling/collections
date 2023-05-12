//
//  DoublyLinkedList+Memory.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    mutating func malloc(_ node : Node) -> Int {
        let index = buffer.count
        buffer.append(node)
        return index
    }
    
    mutating func free(_ index : Int) {
        /* Exchange index with the last element of buffer and adjust pointers
         * properly.
         */
        buffer.swapAt(index, buffer.endIndex - 1)
        /* Don't forget to modify first and last pointers. */
        if first_ptr == buffer.endIndex - 1 {
            first_ptr = index
        }
        if last_ptr == buffer.endIndex - 1 {
            last_ptr = index
        }
        if let prev_ptr = buffer[index].prev {
            buffer[prev_ptr].next = index
        }
        if let next_ptr = buffer[index].next {
            buffer[next_ptr].prev = index
        }
        buffer.removeLast()
    }
}
