//
//  AdjacencyMatrix.swift
//
//
//  Created by Fang Ling on 2023/5/24.
//

public struct AdjacencyMatrix {
    /* Number of vertices in this graph */
    public private(set) var count : Int
    /* Boolean whether or not graph is directed */
    public private(set) var is_directed : Bool
    var matrix : [[Int]]

    public init(count : Int, is_directed : Bool) {
        self.count = count
        self.is_directed = is_directed
        matrix = [[Int]](repeating: [Int](repeating: 0, count: count),
                         count: count)
    }

    public mutating func insert_edge(u : Int, v : Int, weight : Int = 1) {
        if !is_directed {
            matrix[v][u] = weight
        }
        matrix[u][v] = weight
    }

    public func has_edge(u : Int, v : Int) -> Bool {
        return matrix[u][v] != 0
    }

    public mutating func remove_edge(u : Int, v : Int) {
        if !is_directed {
            matrix[v][u] = 0
        }
        matrix[u][v] = 0
    }

    public func get_edge(u : Int, v : Int) -> Int {
        return matrix[u][v]
    }
}
