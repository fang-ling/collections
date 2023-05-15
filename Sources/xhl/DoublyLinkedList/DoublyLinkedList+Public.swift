//
//  DoublyLinkedList+Public.swift
//  
//
//  Created by Fang Ling on 2023/5/13.
//

import Foundation

extension DoublyLinkedList {
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
    
    /// The first element of the collection.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let lastNumber = numbers.last {
    ///         print(lastNumber)
    ///     }
    ///     // Prints "10"
    ///
    /// - Complexity: O(1)
    @inlinable public var first : Element? {
        get {
            guard let ptr = first_ptr else { return nil }
            return buffer[ptr].item
        }
    }
    
    /// The last element of the collection.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let lastNumber = numbers.last {
    ///         print(lastNumber)
    ///     }
    ///     // Prints "50"
    ///
    /// - Complexity: O(1)
    @inlinable public var last : Element? {
        get {
            guard let ptr = last_ptr else { return nil }
            return buffer[ptr].item
        }
    }
    
    /// Removes and returns the first element of the collection.
    ///
    /// The collection must not be empty.
    ///
    ///     var bugs = ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]
    ///     bugs.removeFirst()
    ///     print(bugs)
    ///     // Prints "["Bumblebee", "Cicada", "Damselfly", "Earwig"]"
    ///
    /// Calling this method may invalidate any existing indices for use with
    /// this collection.
    ///
    /// - Returns: The removed element.
    ///
    /// - Complexity: O(1)
    @discardableResult
    @inlinable public mutating func remove_first() -> Element {
        precondition(!is_empty,
                     "Can't remove items from an empty collection")
        return unlink_first(first_ptr!)
    }
    
    /// Removes and returns the last element of the collection.
    ///
    /// The collection must not be empty.
    ///
    ///     var bugs = ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]
    ///     bugs.removeFirst()
    ///     print(bugs)
    ///     // Prints "["Aphid", "Bumblebee", "Cicada", "Damselfly"]"
    ///
    /// Calling this method may invalidate any existing indices for use with
    /// this collection.
    ///
    /// - Returns: The removed element.
    ///
    /// - Complexity: O(1)
    @discardableResult
    @inlinable public mutating func remove_last() -> Element {
        precondition(!is_empty,
                     "Can't remove items from an empty collection")
        return unlink_last(last_ptr!)
    }
    
    /// Adds a new element at the front of the collection.
    ///
    /// Use this method to append a single element to the front of a collection.
    ///
    ///     var numbers : DoublyLinkedList = [1, 2, 3, 4, 5]
    ///     numbers.prepend(100)
    ///     print(numbers)
    ///     // Prints "[100, 1, 2, 3, 4, 5]"
    ///
    /// - Parameter new_element: The element to prepend to the deque.
    ///
    /// - Complexity: O(1)
    @inlinable public mutating func prepend(_ new_element : Element) {
        link_first(new_element)
    }
    
    /// Adds a new element at the end of the collection.
    ///
    /// Use this method to append a single element to the end of a collection.
    ///
    ///     var numbers : DoublyLinkedList = [1, 2, 3, 4, 5]
    ///     numbers.append(100)
    ///     print(numbers)
    ///     // Prints "[1, 2, 3, 4, 5, 100]"
    ///
    /// - Parameter new_element: The element to append to the collection.
    ///
    /// - Complexity: O(1)
    @inlinable public mutating func append(_ new_element : Element) {
        link_last(new_element)
    }
}
