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
        self.addSimple(title: "Array<Int> append",
                       input: [Int].self) { input in
            let array = CCollections.Array<Int>()
            for i in input {
                array.append(i)
            }
            //precondition(array.count == input.count)
            blackHole(array)
        }
        
        self.addSimple(title: "Swift Array<Int> append",
                       input: [Int].self) { input in
            var array = [Int]()
            for i in input {
                array.append(i)
            }
            blackHole(array)
        }
    }
}
