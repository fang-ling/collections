//
//  BinaryHeap.swift
//
//
//  Created by Fang Ling on 2023/8/5.
//

import Foundation

//----------------------------------------------------------------------------//
//                         Structure Definition                               //
//----------------------------------------------------------------------------//
public struct BinaryHeap<Element : Comparable & Hashable> {
  @usableFromInline
  var _storage : [Element]
  
  /// A dictionary mapping elements to indices
  @usableFromInline
  var _dict : [Element : Int]
  
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
  //                     Inspection of a BinaryHeap                         //
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
  /// The number of elements in the binary heap.
  @inlinable
  public var count : Int { return _storage.count }
  
  /// A Boolean value indicating whether the binary heap is empty.
  @inlinable
  public var is_empty : Bool { return _storage.isEmpty }
  
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
  //                     Creation of a BinaryHeap                           //
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
  /// Creates a new, empty heap.
  @inlinable
  public init() {
    _storage = []
    _dict = [:]
  }
  
  /// Initializes a heap from a sequence.
  /// - Complexity: O(n), where n is the number of items in `elements`.
  @inlinable
  public init<S : Sequence>(_ elements : S) where S.Element == Element {
    _storage = Array(elements)
    _dict = [:]
    guard count > 1 else { return }
    
    for i in _storage.indices {
      _dict[_storage[i]] = i
    }
    for i in stride(from: count / 2 - 1, through: 0, by: -1) {
      max_heapify_down(i)
    }
  }
}

extension BinaryHeap: ExpressibleByArrayLiteral {
  /// Creates a new heap from the contents of an array literal.
  ///
  /// **Do not call this initializer directly.** It is used by the compiler when
  /// you use an array literal. Instead, create a new heap using an array
  /// literal as its value by enclosing a comma-separated list of values in
  /// square brackets. You can use an array literal anywhere a heap is expected
  /// by the type context.
  ///
  /// - Parameter elements: A variadic list of elements of the new heap.
  public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }
}

//----------------------------------------------------------------------------//
//                         Index calculation                                  //
//----------------------------------------------------------------------------//
@inlinable
func bh_parent(_ i : Int) -> Int { return (i - 1) / 2 }

@inlinable
func bh_left(_ i : Int) -> Int { return 2 * i + 1 }

@inlinable
func bh_right(_ i : Int) -> Int { return 2 * i + 2 }

extension BinaryHeap {
  @inlinable
  mutating func swap_at(_ i : Int, _ j : Int) {
    _dict[_storage[i]] = j
    _dict[_storage[j]] = i
    _storage.swapAt(i, j)
  }
}

//----------------------------------------------------------------------------//
//                         Maintenance of the BinaryHeap property             //
//----------------------------------------------------------------------------//
extension BinaryHeap {
  ///Maintain the max heap property from node i all the way up to root.
  @inlinable
  mutating func max_heapify_up(_ i : Int) {
    if i == 0 { /* We are at root node now. */
      return
    }
    if _storage[bh_parent(i)] <= _storage[i] {
      swap_at(bh_parent(i), i) /* Exchange i with parent(i) */
      /*
       * Current node is satisfy max heap property, but maybe not its
       * parent. Fix this recursively.
       */
      max_heapify_up(bh_parent(i))
    }
  }
  
  ///Maintain the max heap property from node i all the way down to leaf.
  @inlinable
  mutating func max_heapify_down(_ i : Int) {
    if i >= count / 2 { /* No children, we are done */
      return
    }
    var j = 0
    /* Find i's largest children j. */
    if bh_left(i) < count && bh_right(i) < count { /* Both children exist */
      j = _storage[bh_left(i)] > _storage[bh_right(i)] ? bh_left(i) : bh_right(i)
    } else if bh_left(i) < count && bh_right(i) >= count { /* Left only */
      j = bh_left(i)
    } else if bh_left(i) >= count && bh_right(i) < count { /* Right only */
      j = bh_right(i)
    } else { /* Will never happen */
      print("error")
      return
    }
    /*
     * If i is smaller than j (i's largest child), we are violate the max
     * heap property. Fix it by swap i.key with j.key and then recur on j.
     */
    if _storage[i] < _storage[j] {
      swap_at(i, j)
      max_heapify_down(j)
    }
  }
}

//----------------------------------------------------------------------------//
//                         Lookup                                             //
//----------------------------------------------------------------------------//
extension BinaryHeap {
  /// Returns the largest element in a heap in constant time.
  @inlinable
  public var max : Element? {
    return _storage.first
  }
}

//----------------------------------------------------------------------------//
//                         Insertion                                          //
//----------------------------------------------------------------------------//
extension BinaryHeap {
  /// Inserts a new item into heap.
  /// - Complexity: O(lg n), where n is the length of the heap
  @inlinable
  public mutating func insert(_ new_element : Element) {
    _storage.append(new_element)
    _dict[new_element] = count - 1
    max_heapify_up(count - 1)
  }
}

//----------------------------------------------------------------------------//
//                         Removal                                            //
//----------------------------------------------------------------------------//
extension BinaryHeap {
  /// Removes the max item in the heap.
  @inlinable
  @discardableResult
  public mutating func remove_max() -> Element {
    swap_at(0, count - 1)
    /* It's necessary to first do remove to update `count` */
    let r = _storage.removeLast()
    _dict.removeValue(forKey: r)
    max_heapify_down(0)
    return r
  }
}

//----------------------------------------------------------------------------//
//                        Accessing Elements                                  //
//----------------------------------------------------------------------------//
extension BinaryHeap {
  /// - Complexity: O(lg n), where n is the length of the heap
  @inlinable
  public mutating func replace(_ old_element : Element, with element : Element) {
    guard let i = _dict[old_element] else {
      fatalError("no such element: \(old_element)")
    }
    if element < _storage[i] {
      fatalError("new element is smaller than current element")
    }
    
    _storage[i] = element
    max_heapify_up(i)
  }
}
