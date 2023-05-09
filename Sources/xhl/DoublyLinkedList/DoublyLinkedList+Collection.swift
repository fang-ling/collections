//
//  DoublyLinkedList+Collection.swift
//  
//
//  Created by Fang Ling on 2023/5/8.
//

import Foundation

extension DoublyLinkedList {
    /* Links e as first element. */
    mutating func link_first(_ e : Element) {
        let f = first_ptr
        let new_node_ptr = malloc(Node(prev: nil, item: e, next: f))
        first_ptr = new_node_ptr
        if f == nil {
            last_ptr = new_node_ptr
        } else {
            buffer[f!].prev = new_node_ptr
        }
    }
    
    /* Links e as last element. */
    mutating func link_last(_ e : Element) {
        let l = last_ptr
        let new_node_ptr = malloc(Node(prev: l, item: e, next: nil))
        last_ptr = new_node_ptr
        if l == nil {
            first_ptr = new_node_ptr
        } else {
            buffer[l!].next = new_node_ptr
        }
    }
    
    /* Inserts element e before non-nil Node successor. */
    mutating func link_before(_ e : Element, _ successor_ptr : Int?) {
        /// assert successor != nil
        let predecessor_ptr = buffer[successor_ptr!].prev
        let new_node_ptr = malloc(Node(prev: predecessor_ptr,
                                       item: e,
                                       next: successor_ptr))
        buffer[successor_ptr!].prev = new_node_ptr
        if predecessor_ptr == nil {
            first_ptr = new_node_ptr
        } else {
            buffer[predecessor_ptr!].next = new_node_ptr
        }
    }
}
