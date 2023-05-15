//
//  Swift-Deque.swift
//  
//
//  Created by Fang Ling on 2023/5/14.
//

import Foundation
import CollectionsBenchmark
import Collections

extension Benchmark {
    public mutating func add_swift_deque_benchmark() {
        self.addSimple(
            title: "Swift.Deque<Int> append",
            input: [Int].self
        ) { input in
            var deque : Deque<Int> = []
            for i in input {
                deque.append(i)
            }
            blackHole(deque)
        }
        
        self.addSimple(
            title: "Swift.Deque<Int> prepend",
            input: [Int].self
        ) { input in
            var deque : Deque<Int> = []
            for i in input {
                deque.prepend(i)
            }
            blackHole(deque)
        }
        
        self.add(
            title: "Swift.Deque<Int> removeLast",
            input: Int.self
        ) { size in
            return { timer in
                var deque = Deque(Array(0 ..< size))
                timer.measure {
                    for _ in 0 ..< size {
                        deque.removeLast()
                    }
                }
                precondition(deque.isEmpty)
                blackHole(deque)
            }
        }
        
        self.add(
            title: "Swift.Deque<Int> removeFirst",
            input: Int.self
        ) { size in
            return { timer in
                var deque = Deque(Array(0 ..< size))
                timer.measure {
                    for _ in 0 ..< size {
                        deque.removeFirst()
                    }
                }
                precondition(deque.isEmpty)
                blackHole(deque)
            }
        }
    }
}
