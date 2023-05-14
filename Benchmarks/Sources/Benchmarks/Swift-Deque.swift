//
//  Deque.swift
//  
//
//  Created by Fang Ling on 2023/5/14.
//

import Foundation
import CollectionsBenchmark
import Collections

extension Benchmark {
    public mutating func add_deque_benchmark() {
        self.addSimple(
            title: "Swift.Deque<Int> append",
            input: [Int].self
        ) { input in
            var deque : Deque<Int> = []
            for i in input {
                deque.append()
            }
        }
    }
}
