//
//  File.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    mutating func link_first(_ e : Element) {
        let new_node_ptr = add_to_buffer(node: Node(item: e,
                                                    next: first_ptr,
                                                    prev: nil))
        first_ptr = new_node_ptr
        if first_ptr == nil {
            last_ptr = new_node_ptr
        } else {
            buffer[first_ptr!].prev = new_node_ptr
        }
    }
}
