//
//  Stack.swift
//  
//
//  Created by Fang Ling on 2023/5/16.
//

import Foundation

@frozen
public struct Stack<Element> {
    @usableFromInline var buffer : [Element]
    
    /* Constructs an empty stack. */
    @inlinable
    public init() {
        buffer = [Element]()
    }
}
