//
//  AdjacencyList.swift
//
//
//  Created by Fang Ling on 2023/5/26.
//

import Foundation

public struct AdjacencyEdge : Equatable {
    public var v : Int
    public var weight : Int
}

public struct AdjacencyList {
    /* Number of vertices in this graph */
    public var count : Int
    public var adj : [[AdjacencyEdge]]

    public init(count : Int) {
        self.count = count
        adj = [[AdjacencyEdge]](
          repeating: [AdjacencyEdge](),
          count: count
        )
    }

    public mutating func insert_edge(u : Int, v : Int, weight : Int = 1) {
        adj[u].append(AdjacencyEdge(v: v, weight: weight))
    }

    /* O(n) time */
    public mutating func contains(u : Int, v : Int) -> Bool {
        for e in adj[u] {
            if e.v == v {
                return true
            }
        }
        return false
    }
}
