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
        let last_index = buffer.endIndex - 1
        buffer.swapAt(index, last_index)
        /* Don't forget to modify first and last pointers. */
        if first_ptr == last_index {
            first_ptr = index
        } else if first_ptr == index {
            first_ptr = last_index
        }
        if last_ptr == last_index {
            last_ptr = index
        } else if last_ptr == index {
            last_ptr = last_index
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
