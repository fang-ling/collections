//
//  red-black-tree-benchmark.swift
//  
//
//  Created by Fang Ling on 2023/3/16.
//

import Foundation
import CollectionsBenchmark
import Collections
import CCollections

extension Benchmark {
    public mutating func add_red_black_tree_benchmarks() {
        self.add(
            title: "RedBlackTree<Int64> insert",
            input: [Int].self
        ) { input in
            return { timer in
                var input64 = [Int64]()
                for i in input {
                    input64.append(Int64(i))
                }
                let tree = RedBlackTree()
                timer.measure {
                    for i in input64 {
                        tree.insert(i)
                    }
                }
                /* Verify the correctness of my implementation. ;> */
                precondition(tree.count == tree.count)
                blackHole(tree)
                //tree.deinit()
            }
        }
        
        self.add(
            title: "RedBlackTree<Int64> removal",
            input: [Int].self
        ) { input in
            return { timer in
                let tree = RedBlackTree()
                var input64 = [Int64]()
                for i in input {
                    input64.append(Int64(i))
                    tree.insert(Int64(i))
                }
                timer.measure {
                    for i in input64 {
                        _ = tree.remove(i)
                    }
                }
                blackHole(tree)
                //tree.deinit()
            }
        }
        
        self.add(
            title: "RedBlackTree<Int64> lookup",
            input: [Int].self
        ) { input in
            return { timer in
                let tree = RedBlackTree()
                for i in input {
                    tree.insert(Int64(i))
                }
                timer.measure {
                    blackHole(tree.max())
                }
                blackHole(tree)
                //heap.deinit()
            }
        }
    }
}
