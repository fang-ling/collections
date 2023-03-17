//
//  File.swift
//  
//
//  Created by Fang Ling on 2023/3/17.
//

import Collections
import CollectionsBenchmark

extension Benchmark {
    public mutating func add_swift_heap_benchmark() {
        self.add(
            title: "Swift Heap<Int> insert",
            input: [Int].self
        ) { input in
            return { timer in
                var heap = Heap<Int>()
                timer.measure {
                    for i in input {
                        heap.insert(i)
                    }
                }
                blackHole(heap)
            }
        }
        
        self.add(
            title: "Swift Heap<Int> insert 4x",
            input: [Int].self
        ) { input in
            return { timer in
                var heap = Heap<Int>()
                timer.measure {
                    for i in input {
                        heap.insert(i)
                        heap.insert(i)
                        heap.insert(i)
                        heap.insert(i)
                    }
                }
                blackHole(heap)
            }
        }
    }
}
