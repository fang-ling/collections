//
//  vEBTree.swift
//  
//
//  Created by Fang Ling on 2023/3/16.
//
import Foundation

public class vEBTree {
    var u : Int
    var lower_sqrt : Int
    var upper_sqrt : Int

    private var max : Int?
    var min : Int?
    var max_count : Int
    var min_count : Int

    var summary : vEBTree?
    var cluster : [vEBTree]

    private func high(_ x : Int) -> Int {
        return x / lower_sqrt
    }

    private func low(_ x : Int) -> Int {
        return x % lower_sqrt
    }

    private func index(_ x : Int, _ y : Int) -> Int {
        return x * lower_sqrt + y
    }

    public init(u : Int) {
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
    }
    
    public func maximum() -> Int? {
        return max
    }
}
