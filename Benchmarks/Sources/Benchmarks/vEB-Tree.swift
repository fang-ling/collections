//
//  vEB-Tree.swift
//  
//
//  Created by Fang Ling on 2023/3/17.
//

import CollectionsBenchmark
import XHL
import Foundation

extension Int {
    public static func next_power(_ x : Int) -> Int {
        var u = 1
        while u < x { u <<= 1 }
        return u < 2 ? 2 : u
    }
}

extension Benchmark {
    public mutating func add_veb_tree_benchmark() {
        self.addSimple(
            title: "vEB-Tree (Int) build empty tree",
            input: Int.self
        ) { size in
            blackHole(vEBTree(u: Int.next_power(size)))
        }
        
        self.add(
            title: "vEB-Tree (Int) insert",
            input: [Int].self
        ) { input in
            return { timer in
                timer.measure {
                    let veb_tree = vEBTree(u: Int.next_power(input.count))
                    for i in input {
                        veb_tree.insert(i)
                    }
                    blackHole(veb_tree)
                }
            }
        }
        
        self.add(
            title: "vEB-Tree (Int) removal",
            input: [Int].self
        ) { input in
            return { timer in
                let veb_tree = vEBTree(u: Int.next_power(input.count))
                for i in input {
                    veb_tree.insert(i)
                }
                timer.measure {
                    for i in input {
                        veb_tree.remove(i)
                    }
                }
            }
        }
        
        self.add(
            title: "vEB-Tree (Int) insert 4x",
            input: [Int].self
        ) { input in
            return { timer in
                timer.measure {
                    let veb_tree = vEBTree(u: Int.next_power(input.count))
                    for i in input {
                        veb_tree.insert(i)
                        veb_tree.insert(i)
                        veb_tree.insert(i)
                        veb_tree.insert(i)
                    }
                    blackHole(veb_tree)
                }
            }
        }
    }
}
