//
//  AdjacencyMatrix.swift
//
//
//  Created by Fang Ling on 2023/5/24.
//

public struct AdjacencyMatrix {
    /* Number of vertices in this graph */
    public var count : Int
    var matrix : [[Int]]

    public init(count : Int) {
        self.count = count
        matrix = [[Int]](
          repeating: [Int](repeating: 0, count: count),
          count: count
        )
    }

    public mutating func insert_edge(u : Int, v : Int, weight : Int = 1) {
        matrix[u][v] = weight
    }

    public func contains(u : Int, v : Int) -> Bool {
        return matrix[u][v] != 0
    }

    public mutating func remove_edge(u : Int, v : Int) {
        matrix[u][v] = 0
    }

    public func get_edge(u : Int, v : Int) -> Int {
        return matrix[u][v]
    }
}
