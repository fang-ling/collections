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
            input: [Int].self
        ) { input in
            return { timer in
                var input64 = [Int64]()
                for i in input {
                    input64.append(Int64(i))
                }
                let heap = BinaryHeap()
                timer.measure {
                    for i in input64 {
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
            input: [Int].self
        ) { input in
            return { timer in
                var input64 = [Int64]()
                for i in input {
                    input64.append(Int64(i));
                }
                var heap = Heap<Int64>()
                timer.measure {
                    for i in input64 {
                        heap.insert(i)
                    }
                }
                /* Verify the correctness of my implementation. ;> */
                blackHole(heap)
            }
        }
        
        self.add(
            title: "BinaryHeap<Int64> removal",
            input: [Int].self
        ) { input in
            return { timer in
                let heap = BinaryHeap()
                for i in input {
                    heap.insert(Int64(i))
                }
                timer.measure {
                    while !heap.is_empty {
                        heap.remove()
                    }
                }
                /* Verify the correctness of my implementation. ;> */
                precondition(heap.count == heap.count)
                blackHole(heap)
                heap.deinit()
            }
        }
        
        self.add(
            title: "Swift Heap<Int64> removal",
            input: [Int].self
        ) { input in
            return { timer in
                var heap = Heap<Int64>()
                for i in input {
                    heap.insert(Int64(i))
                }
                timer.measure {
                    while !heap.isEmpty {
                        _ = heap.removeMax()
                    }
                }
                blackHole(heap)
            }
        }
        
        self.add(
            title: "BinaryHeap<Int64> lookup",
            input: [Int].self
        ) { input in
            return { timer in
                let heap = BinaryHeap()
                for i in input {
                    heap.insert(Int64(i))
                }
                timer.measure {
                    blackHole(heap.max())
                }
                /* Verify the correctness of my implementation. ;> */
                precondition(heap.count == heap.count)
                blackHole(heap)
                heap.deinit()
            }
        }
        
        self.add(
            title: "Swift Heap<Int64> lookup",
            input: [Int].self
        ) { input in
            return { timer in
                var heap = Heap<Int64>()
                for i in input {
                    heap.insert(Int64(i))
                }
                timer.measure {
                    blackHole(heap.max())
                }
                blackHole(heap)
            }
        }
    }
}
