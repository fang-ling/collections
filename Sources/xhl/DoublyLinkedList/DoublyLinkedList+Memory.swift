//
//  DoublyLinkedList+Memory.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    mutating func malloc(_ node : Node) -> Int {
        var index : Int
        if unused.last != nil {
            index = unused.removeLast()
            buffer[index] = node
        } else {
            index = buffer.count
            buffer.append(node)
        }
        return index
    }
    
    mutating func free(_ index : Int) {
        if index == buffer.count - 1 {
            buffer.removeLast()
        } else {
            unused.append(index)
        }
    }
}
