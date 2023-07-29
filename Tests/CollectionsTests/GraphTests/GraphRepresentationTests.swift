//
//  GraphRepresentationTests.swift
//
//
//  Created by Fang Ling on 2023/7/29.
//

import XCTest
@testable import Collections

final class GraphRepresentationTests : XCTestCase {
    func test_list() {
        var G = AdjacencyList(count: 5)
        G.insert_edge(u: 0, v: 1); G.insert_edge(u: 1, v: 0)
        G.insert_edge(u: 0, v: 4); G.insert_edge(u: 4, v: 0)
        G.insert_edge(u: 1, v: 4); G.insert_edge(u: 4, v: 1)
        G.insert_edge(u: 1, v: 2); G.insert_edge(u: 2, v: 1)
        G.insert_edge(u: 1, v: 3); G.insert_edge(u: 3, v: 1)
        G.insert_edge(u: 2, v: 3); G.insert_edge(u: 3, v: 2)
        G.insert_edge(u: 3, v: 4); G.insert_edge(u: 4, v: 3)

        XCTAssertTrue(G.contains(u: 2, v: 1))
        XCTAssertFalse(G.contains(u: 0, v: 3))

        XCTAssertEqual(
          G.adj[2],
          [AdjacencyEdge(v: 1, weight: 1), AdjacencyEdge(v: 3, weight: 1)]
        )
    }

    func test_matrix() {
        var G = AdjacencyMatrix(count: 5)
        G.insert_edge(u: 0, v: 1); G.insert_edge(u: 1, v: 0)
        G.insert_edge(u: 0, v: 4); G.insert_edge(u: 4, v: 0)
        G.insert_edge(u: 1, v: 4); G.insert_edge(u: 4, v: 1)
        G.insert_edge(u: 1, v: 2); G.insert_edge(u: 2, v: 1)
        G.insert_edge(u: 1, v: 3); G.insert_edge(u: 3, v: 1)
        G.insert_edge(u: 2, v: 3); G.insert_edge(u: 3, v: 2)
        G.insert_edge(u: 3, v: 4); G.insert_edge(u: 4, v: 3)

        XCTAssertTrue(G.contains(u: 2, v: 1))
        XCTAssertFalse(G.contains(u: 0, v: 3))

        XCTAssertEqual(
          G.matrix,
          [
            [0, 1, 0, 0, 1],
            [1, 0, 1, 1, 1],
            [0, 1, 0, 1, 0],
            [0, 1, 1, 0, 1],
            [1, 1, 0, 1, 0]
          ]
        )
    }
}
