//
//  Stack+Public.swift
//  
//
//  Created by Fang Ling on 2023/5/16.
//

import Foundation

extension Stack {
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
    ///     let horseName = "Silver"
    ///     if horseName.isEmpty {
    ///         print("My horse has no name.")
    ///     } else {
    ///         print("Hi ho, \(horseName)!")
    ///     }
    ///     // Prints "Hi ho, Silver!")
    ///
    /// - Complexity: O(1)
    @inlinable @inline(__always)
    public var is_empty : Bool {
        buffer.isEmpty
    }
    
    /// The top-most element of the stack.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    /// - Complexity: O(1)
    @inlinable public var top : Element? {
        get {
            guard let top_element = buffer.last else { return nil }
            return top_element
        }
    }
    
    /// Removes and returns the top-most element of the stack.
    ///
    /// The collection must not be empty.
    ///
    /// - Returns: The removed element.
    ///
    /// - Complexity: O(1)
    @discardableResult
    @inlinable public mutating func pop() -> Element {
        precondition(!is_empty,
                     "Can't remove items from an empty collection")
        return buffer.removeLast()
    }
    
    /// Adds a new element on top of the stack.
    ///
    /// - Parameter new_element: The element to append to the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public mutating func push(_ new_element : Element) {
        buffer.append(new_element)
    }
}
