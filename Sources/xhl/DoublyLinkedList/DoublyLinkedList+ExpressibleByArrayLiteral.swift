//
//  DoublyLinkedList+ExpressibleByArrayLiteral.swift
//  
//
//  Created by Fang Ling on 2023/5/13.
//

import Foundation

extension DoublyLinkedList : ExpressibleByArrayLiteral {
    /// Creates a new doubly linked list from the contents of an array literal.
    ///
    /// Do not call this initializer directly. It is used by the compiler when
    /// you use an array literal. Instead, create a new list using an array
    /// literal as its value by enclosing a comma-separated list of values in
    /// square brackets. You can use an array literal anywhere a list is
    /// expected by the type context.
    ///
    /// - Parameter elements: A variadic list of elements of the new deque.
    @inlinable
    @inline(__always)
    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
