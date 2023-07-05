//
//  Queue+Public.swift
//  
//
//  Created by Fang Ling on 2023/5/16.
//

import Foundation

extension Queue {
    /// The number of elements in the collection.
    ///
    /// To check whether a collection is empty, use its `isEmpty` property
    /// instead of comparing `count` to zero.
    ///
    /// - Complexity: O(1)
    @inlinable @inline(__always)
    public var count : Int {
        buffer.count
    }
    
    /// A Boolean value indicating whether the collection is empty.
    ///
    /// When you need to check whether your collection is empty, use the
    /// `isEmpty` property instead of checking that the `count` property is
    /// equal to zero.
    ///
    /// - Complexity: O(1)
    @inlinable @inline(__always)
    public var is_empty : Bool {
        buffer.is_empty
    }
    
    /// The first element of the queue.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    /// - Complexity: O(1)
    @inlinable public var front : Element? {
        get {
            guard let front = buffer.first else { return nil }
            return front
        }
    }
    
    /// Removes and returns the first element of the queue.
    ///
    /// The collection must not be empty.
    ///
    /// - Returns: The removed element.
    ///
    /// - Complexity: O(1)
    @discardableResult
    @inlinable public mutating func dequeue() -> Element {
        precondition(!is_empty,
                     "Can't remove items from an empty collection")
        return buffer.remove_first()
    }
    
    /// Adds a new element at the end of the queue.
    ///
    /// - Parameter new_element: The element to append to the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public mutating func enqueue(_ new_element : Element) {
        buffer.append(new_element)
    }
}
