//
//  AdjacencyList.swift
//
//
//  Created by Fang Ling on 2023/5/26.
//

import Foundation

public struct AdjacencyEdge : Equatable {
    public var v : Int
    public var w : Int

    public init(v : Int, w : Int) {
        self.v = v
        self.w = w
    }
}

public struct AdjacencyList {
    /* Number of vertices in this graph */
    public var count : Int
    public var adj : [[AdjacencyEdge]]
    public var edges : [(Int, Int, Int)]

    public init(count : Int) {
        self.count = count
        adj = [[AdjacencyEdge]](
          repeating: [AdjacencyEdge](),
          count: count
        )
        edges = [(Int, Int, Int)]()
    }

    public init(count : Int, edges : [(Int, Int, Int)]) {
        self.init(count: count)
        self.edges = edges
        for e in edges {
            adj[e.0].append(AdjacencyEdge(v: e.1, w: e.2))
        }
    }

    public mutating func insert_edge(u : Int, v : Int, w : Int = 1) {
        adj[u].append(AdjacencyEdge(v: v, w: w))
        edges.append((u, v, w))
    }
}
