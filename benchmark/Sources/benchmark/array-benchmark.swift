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
                array.deinit()
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
        
        self.add(
            title: "Array<Int> random insertions",
            input: Insertions.self
        ) { insertions in
            return { timer in
                let insertions = insertions.values
                let array = CCollections.Array<Int>()
                timer.measure {
                    for i in insertions.indices {
                        array.insert(insertions[i], at: Int64(insertions[i]))
                    }
                }
                array.deinit()
                blackHole(array)
            }
        }
        
        self.add(
            title: "Swift Array<Int> random insertions",
            input: Insertions.self
        ) { insertions in
            return { timer in
                let insertions = insertions.values
                var array: [Int] = []
                timer.measure {
                    for i in insertions.indices {
                        array.insert(i, at: insertions[i])
                    }
                }
                blackHole(array)
            }
        }
        
        self.add(
            title: "Array<Int> remove_last",
            input: Int.self
        ) { size in
            return { timer in
                let array = CCollections.Array<Int>()
                for i in 0 ..< size {
                    array.append(i)
                }
                timer.measure {
                    while !array.is_empty {
                        array.remove_last()
                    }
                }
                precondition(array.is_empty)
                precondition(array.count == 0)
            }
        }
        
        self.add(
            title: "Swift Array<Int> removeLast",
            input: Int.self
        ) { size in
            return { timer in
                var array = [Int](0 ..< size)
                timer.measure {
                    while !array.isEmpty {
                        array.removeLast()
                    }
                }
            }
        }
        
        self.add(
            title: "Array<Int> random removals",
            input: Insertions.self
        ) { insertions in
            let removals = insertions.values.reversed()
            return { timer in
                let array = CCollections.Array<Int>()
                for i in 0 ..< removals.count {
                    array.append(i)
                }
                timer.measure {
                    for i in removals {
                        array.remove(at: Int64(i))
                    }
                }
                array.deinit()
                blackHole(array)
            }
        }
        
        self.add(
            title: "Swift Array<Int> random removals",
            input: Insertions.self
        ) { insertions in
            let removals = insertions.values.reversed()
            return { timer in
                var array: [Int] = [Int](0 ..< removals.count)
                timer.measure {
                    for i in removals {
                        array.remove(at: i)
                    }
                }
                blackHole(array)
            }
        }
    }
}
