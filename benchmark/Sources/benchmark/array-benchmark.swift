//
//  array-benchmark.swift
//  
//
//  Created by Fang Ling on 2023/3/7.
//

import CollectionsBenchmark
import CCollections

extension Benchmark {
    public mutating func add_array_benchmarks() {
        self.add(
            title: "Array<Int> append",
            input: [Int].self
        ) { input in
            return { timer in
                let array = CCollections.Array<Int>()
                timer.measure {
                    for i in input {
                        array.append(i)
                    }
                }
                /* Verify the correctness of my implementation. ;> */
                precondition(array.count == input.count)
                precondition(array.to_swift_array() == input)
                blackHole(array)
            }
        }
        
        self.add(
            title: "Swift Array<Int> append",
            input: [Int].self
        ) { input in
            return { timer in
                var array = [Int]()
                timer.measure {
                    for i in input {
                        array.append(i)
                    }
                }
                blackHole(array)
            }
        }
    }
}
