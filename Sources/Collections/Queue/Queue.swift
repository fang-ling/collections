//
//  Queue.swift
//  
//
//  Created by Fang Ling on 2023/5/16.
//

import Foundation

@frozen
public struct Queue<Element> {
    @usableFromInline var buffer : DoublyLinkedList<Element>
    
    /* Constructs an empty queue. */
    @inlinable
    public init() {
        buffer = DoublyLinkedList<Element>()
    }
}
