//
//  AdjacencyList.swift
//
//
//  Created by Fang Ling on 2023/5/26.
//

import Foundation

public struct AdjacencyEdge {
    public var v : Int
    public var weight : Int
}

public struct AdjacencyList {
    /* Number of vertices in this graph */
    public private(set) var count : Int
    /* Boolean whether or not graph is directed */
    public private(set) var is_directed : Bool
    var adj_lists : [[AdjacencyEdge]]

    public init(count : Int, is_directed : Bool) {
        self.count = count
        self.is_directed = is_directed
        adj_lists = [[AdjacencyEdge]](repeating: [AdjacencyEdge](),
                                      count: count)
    }

    public func get_adj_list(u : Int) -> [AdjacencyEdge] {
        return adj_lists[u]
    }

    public mutating func insert_edge(u : Int, v : Int, weight : Int = 1) {
        if !is_directed {
            adj_lists[v].append(AdjacencyEdge(v: u, weight: weight))
        }
        adj_lists[u].append(AdjacencyEdge(v: v, weight: weight))
    }

    /* O(n) time */
    public mutating func contains(u : Int, v : Int) -> Bool {
        for e in adj_lists[u] {
            if e.v == v {
                return true
            }
        }
        return false
    }
}
