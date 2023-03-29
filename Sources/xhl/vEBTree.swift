//
//  vEBTree.swift
//  
//
//  Created by Fang Ling on 2023/3/16.
//
import Foundation

public class vEBTree {
    /// The number of elements in the vEB-Tree.
    public var count : Int
    
    private var u : Int
    private var lower_sqrt : Int
    private var upper_sqrt : Int
    
    /// The element with the largest key.
    public private(set) var max : Int?
    /// The element with the smallest key.
    public private(set) var min : Int?
    
    private var max_count : Int
    private var min_count : Int

    private var summary : vEBTree?
    private var cluster : [vEBTree]

    @inline(__always)
    private func high(_ x : Int) -> Int {
        return x / lower_sqrt
    }

    @inline(__always)
    private func low(_ x : Int) -> Int {
        return x % lower_sqrt
    }

    @inline(__always)
    private func index(_ x : Int, _ y : Int) -> Int {
        return x * lower_sqrt + y
    }
    
    /// Creates a new, empty vEB-Tree.
    ///
    /// We call the (multi-) set *{0,1,2,...,u-1}* the __universe__ of values
    /// that can be stored and u the __universe size__. We assume that *u* is an
    /// exact power of 2, i.e., *u=2^k* for some integer *k>=1*.
    ///
    /// - Parameter u: The range of the possible integer values.
    /// - Complexity: O(*u*)
    public init(u : Int) {
        if u < 2 {
            fatalError("The size of universe must be " +
                       "greater than or equal to 2.")
        }
        
        if (u & (u - 1)) != 0 {
            fatalError("The size of universe must be an exact power of 2.")
        }
        
        count = 0
        
        self.u = u
        
        var delta = u
        var bit_count = -1
        while delta > 0 {
            delta >>= 1
            bit_count += 1
        }
        upper_sqrt = 1 << ((bit_count + 1) / 2)
        lower_sqrt = 1 << (bit_count / 2)
        
        min = nil
        max = nil
        min_count = 0
        max_count = 0
        
        cluster = [vEBTree]()
        if u != 2 { /* not leaf */
            summary = vEBTree(u: upper_sqrt)
            cluster.reserveCapacity(upper_sqrt)
            for _ in 0 ..< upper_sqrt {
                cluster.append(vEBTree(u: lower_sqrt))
            }
        }
    }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    public func contains(_ element : Int) -> Bool {
        if element == min || element == max {
            return true
        }
        if u == 2 || element >= u {
            return false
        }
        return cluster[high(element)].contains(low(element))
    }
    
    private func remove(_ element : Int, _ count : Int) {
        var element = element
        if min == max {
            if min == nil || min_count == count {
                min = nil
                max = nil
                min_count = 0
            } else {
                min_count -= count
            }
            max_count = min_count
            return
        }
        if u == 2 {
            if element == 0 {
                min_count -= count
                if min_count == 0 {
                    min = 1
                    min_count = max_count
                }
            } else {
                max_count -= count
                if max_count == 0 {
                    max = 0
                    max_count = min_count
                }
            }
            return
        }
        var new_count = count
        if element == min {
            if min_count > count {
                min_count -= count
                return
            }
            let first_cluster = summary!.min!
            element = index(first_cluster,
                            cluster[first_cluster].min!)
            min = element
            min_count = cluster[first_cluster].min_count
            new_count = cluster[first_cluster].min_count
        }
        cluster[high(element)].remove(low(element), new_count)
        if cluster[high(element)].min == nil {
            summary!.remove(high(element), 1)
            if element == max {
                if max == min {
                    max_count = min_count
                    return
                }
                max_count -= count
                if max_count == 0 {
                    let summary_max = summary!.max
                    if summary_max == nil {
                        max = min
                        max_count = min_count
                    } else {
                        max = index(summary_max!, cluster[summary_max!].max!)
                        max_count = cluster[summary_max!].max_count
                    }
                }
            }
        } else if element == max {
            if max == min {
                max_count = min_count
                return
            }
            max_count -= count
            if max_count == 0 {
                max = index(high(element), cluster[high(element)].max!)
                max_count = cluster[high(element)].max_count
            }
        }
    }
    
    public func remove(_ element : Int) {
        if element >= u {
            fatalError("Element must smaller than the size of universe.")
        }
        remove(element, 1)
        count -= 1
    }
    
    public func predecessor(_ element : Int) -> Int? {
        if element >= u {
            fatalError("Element must smaller than the size of universe.")
        }
        if u == 2 {
            if element == 1 && min == 0 {
                return 0
            }
            return nil
        }
        if max != nil && element > max! {
            return max!
        }
        let min_low = cluster[high(element)].min
        if min_low != nil && low(element) > min_low! {
            let offset = cluster[high(element)].predecessor(low(element))!
            return index(high(element), offset)
        }
        let pred_cluster = summary!.predecessor(high(element))
        if pred_cluster == nil {
            if min != nil && element > min! {
                return min
            }
            return nil
        }
        let offset = cluster[pred_cluster!].max!
        return index(pred_cluster!, offset)
    }
    
    public func successor(_ element : Int) -> Int? {
        if element >= u {
            fatalError("New Element must smaller than the size of universe.")
        }
        if u == 2 {
            if element == 0 && max == 1 {
                return 1
            }
            return nil
        }
        if min != nil && element < min! {
            return min
        }
        let max_low = cluster[high(element)].max
        if max_low != nil && low(element) < max_low! {
            let offset = cluster[high(element)].successor(low(element))!
            return index(high(element), offset)
        }
        let succ_cluster = summary!.successor(high(element))
        if succ_cluster == nil {
            return nil
        }
        let offset = cluster[succ_cluster!].min!
        return index(succ_cluster!, offset)
    }
}

// MARK: Inspecting a vEB Tree
extension vEBTree {
    /// A Boolean value indicating whether the vEB-Tree is empty.
    public var is_empty : Bool {
        get {
            return count == 0
        }
    }
    
    /// A Boolean value indicating whether the vEB-Tree is empty.
    public var isEmpty : Bool {
        get {
            is_empty
        }
    }
}

// MARK: Adding Elements
extension vEBTree {
    /// Insert an element into an empty vEB tree.
    private func empty_tree_insert(_ x : Int, _ count : Int) {
        min = x
        max = x
        min_count = count
        max_count = count
    }
    
    
    /// Inserts a new element into the vEB tree.
    /// - Parameters:
    ///   - x: The new element to insert into the vEB tree.
    ///   - count: Duplicated elements count. (Internally use)
    ///
    /// - Note: (Modified from CLRS 3e)
    /// The procedure works as follows. The `if` statement of Part I tests
    /// whether `self` is an empty vEB tree and, if it is, then the next line
    /// handles this easy case.
    ///
    /// Part II checks if `x` is already an element in the (multi-)set
    /// represented by vEB tree `self` and if so, then the corresponding
    /// duplicated element count will be updated. And we are done.
    ///
    /// Part III & IV assume that `self` is not empty, and therefore some
    /// element will be inserted into one of `self`'s clusters. If `x < min`, as
    /// tested in the first line of Part II, then the x needs to become the new
    /// `min`. We don't want to lose the original `min`, however, and so we need
    /// to insert it into one of `self`'s clusters. In this case the second line
    /// of Part III exchanges `x` with `min`, so that we insert the original
    /// `min` into one of `self`'s clusters.
    ///
    /// We executed Part III only if `self` is not a base-case vEB tree. The 5th
    /// line determines whether the cluster that `x` will go into is currently
    /// empty. If so, then next internal `if` inserts `x`'s cluster number into
    /// the summary and the next line handles the easy case of inserting `x`
    /// into its cluster. In this case, we do not need to update the `summary`,
    /// since `x`'s cluster number is already a member of the `summary`.
    ///
    /// Finally, Part IV take care of updating `max` if `x > max`. Note that if
    /// `self` is a base-case vEB tree that is not empty, then `min` and `max`
    /// are updated properly.
    ///
    private func insert(_ x : Int, _ count : Int) {
        var x = x
        var count = count
        /* Part I */
        if min == nil {
            empty_tree_insert(x, count)
            return
        }
        /* Part II */
        if x == max {
            max_count += count
        }
        if x == min {
            min_count += count
            return
        }
        /* Part III */
        if x < min! {
            swap(&x, &(min!))
            swap(&count, &min_count)
        }
        if (u > 2) { /* not a leaf */
            let h = high(x)
            let l = low(x)
            if (cluster[h].min == nil) {
                summary!.insert(h, 1)
                cluster[h].empty_tree_insert(l, count)
            } else {
                cluster[h].insert(l, count)
            }
        }
        /* Part IV */
        if (x > max!) {
            max = x
            max_count = count
        }
    }
    
    /// Inserts a new element into the vEB tree.
    /// - Parameter new_element: The new element to insert into the vEB tree.
    ///
    /// - Complexity: O(loglog *u*), where *u* is the size of the universe.
    /// (The range of the possible integer values provided by `init(u:)`.)
    public func insert(_ new_element : Int) {
        if new_element >= u {
            fatalError("New element must smaller than the size of universe.")
        }
        insert(new_element, 1)
        count += 1
    }
}
