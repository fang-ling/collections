//
//  Tree+Node.swift
//
//
//  Created by Fang Ling on 2023/7/25.
//

/* General Tree (Each node can have arbitrary number of children) */
@usableFromInline
struct TreeNode<Element> {
    var p_ptr : Int?           /* Pointer to its parent */
    var children_ptrs : [Int?] /* Pointers to its children */
    var payload : Element      /* Actual data */
}
