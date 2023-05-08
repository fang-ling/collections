//
//  DoublyLinkedList+Memory.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    mutating func add_to_buffer(node : Node) -> Int {
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
}
