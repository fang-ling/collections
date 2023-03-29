//
//  UnionFindSet.swift
//  
//
//  Created by Fang Ling on 2023/3/29.
//

import Foundation

public struct UnionFindSet {
    var p : [Int]
    var rank : [Int]
    
    public init(u : Int) {
        p = [Int](repeating: 0, count: u)
        rank = [Int](repeating: 0, count: u)
    }
    
    public mutating func make_set(_ x : Int) {
        p[x] = x
        rank[x] = 0
    }
    
    private mutating func link(_ x : Int, _ y : Int) {
        if rank[x] > rank[y] {
            p[y] = x
        } else {
            p[x] = y
            if rank[x] == rank[y] {
                rank[y] += 1
            }
        }
    }
    
    public mutating func find_set(_ x : Int) -> Int {
        if x != p[x] {
            p[x] = find_set(p[x])
        }
        return p[x]
    }
    
    public mutating func union(_ x : Int, _ y : Int) {
        link(find_set(x), find_set(y))
    }
}
