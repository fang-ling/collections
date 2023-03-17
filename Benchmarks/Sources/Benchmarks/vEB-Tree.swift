//
//  vEB-Tree.swift
//  
//
//  Created by Fang Ling on 2023/3/17.
//

import CollectionsBenchmark
import Collections
import XHL

extension Benchmark {
    public mutating func add_veb_tree_benchmark() {
        self.add(
            title: "vEB-Tree (Int) insert (with overhead)",
            input: [Int].self
        ) { input in
            return { timer in
                timer.measure {
                    var veb_tree = vEBTree(u: input.count)
                    for i in input {
                        veb_tree.insert(i)
                    }
                }
                blackHole(veb_tree)
            }
        }
        
        self.add(
            title: "vEB-Tree (Int) insert (without overhead)",
            input: [Int].self
        ) { input in
            return { timer in
                var veb_tree = vEBTree(u: input.count)
                timer.measure {
                    for i in input {
                        veb_tree.insert(i)
                    }
                }
                blackHole(veb_tree)
            }
        }
    }
}
