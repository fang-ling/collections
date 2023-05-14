//
//  DoublyLinkedList+Node.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    @usableFromInline
    struct Node {
        @usableFromInline var item : Element
        @usableFromInline var next : Int?
        @usableFromInline var prev : Int?
        
        @inlinable init(prev: Int?, item: Element, next: Int?) {
            self.item = item
            self.next = next
            self.prev = prev
        }
    }
}
