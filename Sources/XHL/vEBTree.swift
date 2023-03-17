//
//  vEBTree.swift
//  
//
//  Created by Fang Ling on 2023/3/16.
//
import Foundation

public class vEBTree {
    /// The number of elements in the vEB-Tree
    var count : Int
    
    /// A Boolean value indicating whether the vEB-Tree is empty.
    var is_empty : Bool {
        get {
            return count == 0
        }
    }
    
    /// A Boolean value indicating whether the vEB-Tree is empty.
    var isEmpty : Bool {
        get {
            is_empty
        }
    }
    
    private var u : Int
    private var lower_sqrt : Int
    private var upper_sqrt : Int

    private var max : Int?
    private var min : Int?
    private var max_count : Int
    private var min_count : Int

    private var summary : vEBTree?
    private var cluster : [vEBTree]

    private func high(_ x : Int) -> Int {
        return x / lower_sqrt
    }

    private func low(_ x : Int) -> Int {
        return x % lower_sqrt
    }

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
                       "greater than or equal to 2")
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

    private func empty_tree_insert(_ x : Int, _ count : Int) {
        min = x
        max = x
        min_count = count
        max_count = count
    }

    private func insert(_ x : Int, _ count : Int) {
        var x = x
        var count = count
        if min == nil {
            empty_tree_insert(x, count)
            return
        }
        if x == max {
            max_count += count
        }
        if x == min {
            min_count += count
            return
        }
        if x < min! {
            swap(&x, &(min!))
            swap(&count, &min_count)
        }
        if (u != 2) { /* not a leaf */
            let h = high(x)
            let l = low(x)
            if (cluster[h].min == nil) {
                summary!.insert(h, 1)
                cluster[h].empty_tree_insert(l, count)
            } else {
                cluster[h].insert(l, count)
            }
        }
        if (x > max!) {
            max = x
            max_count = count
        }
    }
    
    public func insert(_ new_element : Int) {
        insert(new_element, 1)
        count += 1
    }
    
    public func minimum() -> Int? {
        return min
    }
    
    public func maximum() -> Int? {
        return max
    }
    
    /// <#Description#>
    /// - Parameter element: <#element description#>
    /// - Returns: <#description#>
    public func contains(_ element : Int) -> Bool {
        if element == min || element == max {
            return true
        }
        if u == 2 {
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
            let first_cluster = summary!.minimum()!
            element = index(first_cluster,
                            cluster[first_cluster].minimum()!)
            min = element
            min_count = cluster[first_cluster].min_count
            new_count = cluster[first_cluster].min_count
        }
        cluster[high(element)].remove(low(element), new_count)
        if cluster[high(element)].minimum() == nil {
            summary!.remove(high(element), 1)
            if element == max {
                if max == min {
                    max_count = min_count
                    return
                }
                max_count -= count
                if max_count == 0 {
                    let summary_max = summary!.maximum()
                    if summary_max == nil {
                        max = min
                        max_count = min_count
                    } else {
                        max = index(summary_max!,
                                    cluster[summary_max!].maximum()!)
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
                max = index(high(element), cluster[high(element)].maximum()!)
                max_count = cluster[high(element)].max_count
            }
        }
    }
    
    public func remove(_ element : Int) {
        remove(element, 1)
        count -= 1
    }
}
