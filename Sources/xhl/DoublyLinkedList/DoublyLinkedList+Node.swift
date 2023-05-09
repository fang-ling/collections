//
//  DoublyLinkedList+Node.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    struct Node {
        var item : Element
        var next : Int?
        var prev : Int?
        
        init(prev: Int?, item: Element, next: Int?) {
            self.item = item
            self.next = next
            self.prev = prev
        }
    }
}
