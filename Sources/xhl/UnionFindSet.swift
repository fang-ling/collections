//
//  UnionFindSet.swift
//
//
//  Created by Fang Ling on 2023/3/29.
//

import Foundation

public struct UnionFindSet<Element : Hashable> {
    @usableFromInline
    var p : [Element : Element]
    @usableFromInline
    var rank : [Element : Int]

    @inlinable
    public init() {
        p = [:]
        rank = [:]
    }

    @inlinable
    public mutating func make_set(_ x : Element) {
        p[x] = x
        rank[x] = 0
    }

    @inlinable
    mutating func link(_ x : Element, _ y : Element) {
        if rank[x] == nil || rank[y] == nil {
            print("No such value with key \(x) or \(y).")
        }

        if rank[x]! > rank[y]! {
            p[y] = x
        } else {
            p[x] = y
            if rank[x] == rank[y] {
                rank[y]! += 1
            }
        }
    }

    @inlinable
    public mutating func find_set(_ x : Element) -> Element {
        if p[x] == nil {
            print("No such value with key \(x).")
        }
        if x != p[x] {
            p[x] = find_set(p[x]!)
        }
        return p[x]!
    }

    @inlinable
    public mutating func union(_ x : Element, _ y : Element) {
        link(find_set(x), find_set(y))
    }
}
