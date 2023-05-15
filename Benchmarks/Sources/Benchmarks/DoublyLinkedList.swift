//
//  DoublyLinkedList.swift
//  
//
//  Created by Fang Ling on 2023/5/14.
//

import Foundation
import CollectionsBenchmark
import xhl

extension Benchmark {
    public mutating func add_doubly_linked_list_benchmark() {
        self.addSimple(
            title: "DoublyLinkedList<Int> append",
            input: [Int].self
        ) { input in
            var ll = DoublyLinkedList<Int>()
            for i in input {
                ll.append(i)
            }
            blackHole(ll)
        }
        
        self.addSimple(
            title: "DoublyLinkedList<Int> prepend",
            input: [Int].self
        ) { input in
            var ll = DoublyLinkedList<Int>()
            for i in input {
                ll.prepend(i)
            }
            blackHole(ll)
        }
        
        self.add(
            title: "DoublyLinkedList<Int> remove_last",
            input: Int.self
        ) { size in
            return { timer in
                var ll = DoublyLinkedList<Int>()
                for i in 0 ..< size {
                    ll.append(i)
                }
                timer.measure {
                    for _ in 0 ..< size {
                        ll.remove_last()
                    }
                }
                precondition(ll.is_empty)
                blackHole(ll)
            }
        }
        
        self.add(
            title: "DoublyLinkedList<Int> remove_first",
            input: Int.self
        ) { size in
            return { timer in
                var ll = DoublyLinkedList<Int>()
                for i in 0 ..< size {
                    ll.append(i)
                }
                timer.measure {
                    for _ in 0 ..< size {
                        ll.remove_first()
                    }
                }
                precondition(ll.is_empty)
                blackHole(ll)
            }
        }
    }
}
