//
//  Tree.swift
//
//
//  Created by Fang Ling on 2023/7/25.
//

import Foundation

public struct Tree<Element> {
    @usableFromInline
    var pool : [TreeNode<Element>]

    ///* Pointer to root node. */
    //@usableFromInline
    //var root_ptr : Int?

    @inlinable
    public init() {
        pool = [TreeNode<Element>]()
    }

    /* Allocate a new tree node */
    mutating func allocate(_ node : TreeNode<Element>) -> Int {
        pool.append(node)
        return pool.count - 1
    }

    // TO-DO: Add a deallocator to save space

    mutating func add_child(node_ptr : Int?, _ new_child_ptr : Int?) {

    }
}
