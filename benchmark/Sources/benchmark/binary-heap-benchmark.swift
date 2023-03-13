//
//  binary-heap-benchmark.swift
//  
//
//  Created by Fang Ling on 2023/3/13.
//

import Foundation
import CollectionsBenchmark
import Collections
import CCollections

extension Benchmark {
    public mutating func add_binary_heap_benchmarks() {
        self.add(
            title: "BinaryHeap<Int64> insert",
            input: [Int64].self
        ) { input in
            return { timer in
                let heap = BinaryHeap()
                timer.measure {
                    for i in input {
                        heap.insert(i)
                    }
                }
                /* Verify the correctness of my implementation. ;> */
                precondition(heap.count == heap.count)
                blackHole(heap)
                heap.deinit()
            }
        }
        
        self.add(
            title: "Swift Heap<Int64> insert",
            input: [Int64].self
        ) { input in
            return { timer in
                var heap = Heap<Int64>()
                timer.measure {
                    for i in input {
                        heap.insert(i)
                    }
                }
                /* Verify the correctness of my implementation. ;> */
                blackHole(heap)
            }
        }
    }
}
